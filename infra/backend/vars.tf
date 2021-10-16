variable "terraform_state_bucket" {
    default = "personal-website-state-bucket"
    description = "Name of the state bucket"
    type = string
}

variable "terraform_state_lock" {
    type = string
    description = "Name of the Dynamo DB backend state lock table"
    default = "personal-website-backend-state-lock"
}

variable "region" {
    type = string
    description = "AWS Region in which resources are deployed"
    default = "ap-southeast-2"
}