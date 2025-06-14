locals {
  github_actions_role_aws_managed_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.github_actions_role_trust_policy.json
}

data "aws_iam_policy_document" "github_actions_role_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.github_actions_role_trust_policy_user]
    }
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_role_aws_managed_policies_attachment" {
  for_each   = toset(local.github_actions_role_aws_managed_policies)
  role       = aws_iam_role.github_actions_role.name
  policy_arn = each.value
}
