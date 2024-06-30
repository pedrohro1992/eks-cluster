# data "aws_iam_policy_document" "aws_lbc_assume_role" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"
#
#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:${var.lbc_release_name}:${local.lbc_sa_name}"]
#     }
#
#     principals {
#       identifiers = [aws_iam_openid_connect_provider.eks.arn]
#       type        = "Federated"
#     }
#   }
# }
#
# resource "aws_iam_role" "aws_lbc" {
#   assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role.json
#   name               = "${var.cluster_name}-external-dns-role"
# }
#
# data "aws_iam_policy_document" "aws_lbc_policy" {
#   statement {
#     actions = [
#       ""
#     ]
#     resources = [""]
#     effect    = "Allow"
#   }
#   statement {
#     actions = [
#     ]
#     resources = ["*"]
#     effect    = "Allow"
#   }
# }
#
# resource "aws_iam_policy" "aws_lbc_policy" {
#   name        = "${var.cluster_name}-aws-lbc-policy"
#   description = ""
#   policy      = data.aws_iam_policy_document.aws_lbc_policy.json
# }
# //Faz o attach da policy na role 
# resource "aws_iam_role_policy_attachment" "aws_lbc_policy" {
#   policy_arn = aws_iam_policy.aws_lbc_policy.arn
#   role       = aws_iam_role.aws_lbc.name
# }

