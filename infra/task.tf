resource "aws_ecs_task_definition" "rakmo_task" {
  family = "rakmo"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = local.ecs_fargate_task_role_arn

  container_definitions = <<DEFINITION
[
  {
    "name": "rakmo",
    "image": "${aws_ecr_repository.rakmo_ecr.repository_url}:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "cpu": 1024,
    "memory": 2048,
    "networkMode": "awsvpc"
  }
]
DEFINITION
}
