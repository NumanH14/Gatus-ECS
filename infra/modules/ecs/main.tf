terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

# provider block will be deleted. just here for testing tf plan purposes
resource "aws_ecs_cluster" "gatus-cluster" {
  name = "gatus-ecs"
  setting {
    name  = "containerInsights"
    value = "enhanced"
  }
}

resource "aws_ecs_service" "gatus-service" {
  name            = "gatus"
  cluster         = aws_ecs_cluster.gatus-cluster.id
  task_definition = aws_ecs_task_definition.gatus-ecs.id
  desired_count   = 2
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.alb-target-group.arn
    container_name   = "gatus-image"
    container_port   = 8080
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = false


  }

}
resource "aws_ecs_task_definition" "gatus-ecs" {
  family                   = "gatus-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_role.arn
  container_definitions = jsonencode([
    {
      name      = "gatus-image"
      image     = "155744200971.dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs:gatus-image"
      cpu       = 1024
      memory    = 2048
      essential = true

      entryPoint = ["/gatus-ecs"]

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

}

data "aws_iam_policy_document" "role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_role" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.role_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = aws_iam_role.ecs_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



