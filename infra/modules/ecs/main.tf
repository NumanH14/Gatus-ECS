resource "aws_ecs_cluster" "gatus-cluster" {
  name = "gatus-ecs"

  configuration {
    execute_command_configuration {
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.cloudwatch_logging.id
      }
    }
  }
  setting {
    name  = "containerInsights"
    value = "enhanced"
  }

}

resource "aws_cloudwatch_log_group" "cloudwatch_logging" {
  name = "cloudwatch-logging"
}

resource "aws_ecs_task_definition" "gatus-ecs" {
  family                   = "gatus-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "gatus-image",
    "image": "155744200971.dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs:gatus-image",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
    "entryPoint": ["/gatus-ecs"],
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

resource "aws_ecs_service" "gatus-service" {
  name            = "gatus"
  cluster         = aws_ecs_cluster.gatus-cluster.id
  task_definition = aws_ecs_task_definition.gatus-ecs.id
  desired_count   = 2
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb-target-group.arn
    container_name   = "gatus"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
