resource "aws_ecs_service" "example_service" {
  name            = "rakmo"
  cluster         = local.infinity_cluster_id
  task_definition = aws_ecs_task_definition.rakmo_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.rakmo_service_security.id]
    subnets         = local.private_subnet_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.elb_target_group.arn
    container_name   = "rakmo"
    container_port   = 80
  }
}

