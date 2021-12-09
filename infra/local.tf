locals {
    infinity_vpc_id = data.terraform_remote_state.infinity.outputs.infinity_vpc_id
    infinity_cluster_id = data.terraform_remote_state.infinity.outputs.infinity_cluster_id
    elb_security_id = data.terraform_remote_state.infinity.outputs.elb_security_id
    ecr_repo_url = data.terraform_remote_state.infinity.outputs.ecr_repo_url
    private_subnet_ids = data.terraform_remote_state.infinity.outputs.private_subnet_ids
    elb_target_arn = data.terraform_remote_state.infinity.outputs.elb_target_arn
    elb_listener_arn = data.terraform_remote_state.infinity.outputs.elb_listener_arn
    ecs_fargate_task_role_arn = data.terraform_remote_state.infinity.outputs.ecs_fargate_task_role_arn
}