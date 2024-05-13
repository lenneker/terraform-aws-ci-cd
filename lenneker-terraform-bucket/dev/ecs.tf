resource "aws_ecr_repository" "my-repo" {
  name                 = "${var.environment}"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecs_task_definition" "service" {
  family = "${var.environment}"
  container_definitions = jsonencode([
    {
      name      = "${var.environment}"
      image     = "${var.environment}"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = "${var.container_port}"
          hostPort      = "${var.container_port}"
        }
      ]
    }
  ])
}


resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}"
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


resource "aws_ecs_service" "service" {
  name            = "${var.environment}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  /*
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]
  */

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "${var.environment}"
    container_port   = "${var.container_port}"
  }

}
