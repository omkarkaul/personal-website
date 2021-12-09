resource "aws_security_group" "rakmo_service_security" {
    name = "rakmo-security-group"
    vpc_id = local.infinity_vpc_id

    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        security_groups = [local.elb_security_id]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}