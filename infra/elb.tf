resource "aws_lb_target_group" "elb_target_group" {
    name = "rakmo-elb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = local.infinity_vpc_id
    target_type = "ip"
}

resource "aws_lb_listener_rule" "rakmo" {
  listener_arn = local.elb_listener_arn
  priority     = 1

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.elb_target_group.arn
  }

  condition {
    host_header {
      values = ["rakmo.io", "www.rakmo.io"]
    }
  }
}