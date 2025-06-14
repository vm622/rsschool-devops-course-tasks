variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "github_actions_role_trust_policy_user" {
  type        = string
  description = "AWS IAM user allowed to assume GitHubActionsRole IAM role"
  default     = ""
}
