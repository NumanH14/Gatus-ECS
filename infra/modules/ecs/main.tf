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
