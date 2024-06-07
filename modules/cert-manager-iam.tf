data "aws_iam_policy_document" "cert_manager_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.cert_manger_release_name}:${local.cert_manager_sa_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "cert_manager" {
  assume_role_policy = data.aws_iam_policy_document.cert_manager_assume_role.json
  name               = "${var.cluster_name}-cert-manager-role"
}

//Trocar para as policy do cert manager: https://cert-manager.io/docs/configuration/acme/dns01/route53/
data "aws_iam_policy_document" "cert_manager_route_53" {
  statement {
    actions = [
      "route53:GetChange"
    ]
    resources = ["arn:aws:route53:::change/*"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
    ]
    resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.public.zone_id}"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "route53:ListHostedZonesByName"
    ]
    // Se tiver dando erro pode ta vindo daqui
    resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.public.zone_id}"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "cert_manager_route_53" {
  name        = "${var.cluster_name}-cert-manager-policy"
  description = "Policy to create route53 records with cert-manager-dnsrole"
  policy      = data.aws_iam_policy_document.cert_manager_route_53.json
}
resource "aws_iam_role_policy_attachment" "cert_manager_route53_policy" {
  policy_arn = aws_iam_policy.cert_manager_route_53.arn
  role       = aws_iam_role.cert_manager.name
}

