variable "region" {
  type        = string
  description = "AWS Region in which resources are deployed"
  default     = "ap-southeast-2"
}

variable "service_state_lock" {
  type        = string
  description = "Name of the Dynamo DB service state lock table"
  default     = "personal-website-state-lock"
}

variable "website_bucket" {
  type        = map(string)
  description = "Names of the website buckets"
  default = {
    root     = "rakmo.io"
    prefixed = "www.rakmo.io"
  }
}