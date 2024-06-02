// Cria policy para poder assumir com a serviceaccount atraves do OIDC provider
data "aws_iam_policy_document" "external_dns_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.external_dns_release_name}:${local.external_dns_sa_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

// Cria a role que a service account vai assumir atravces da assume_role_policy(criada acima)
resource "aws_iam_role" "external_dns" {
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role.json
  name               = "${var.cluster_name}-external-dns-role"
}

// Cria a policy que vai permitir que o External DNS faca as operacoes no Route53
data "aws_iam_policy_document" "external_dns_route_53" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.public.zone_id}"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]
    #TODO Isso aqui parece meio aberto, verificar se realmente necessita de tudo isso de informacao
    resources = ["*"]
    effect    = "Allow"
  }
}

// Cria a policy que vai permitir que o External DNS faca as operacoes no Route53
resource "aws_iam_policy" "external_dns_route_53" {
  name        = "${var.cluster_name}-external-dns-policy"
  description = "Policy to create route53 records with external-dnsrole"
  policy      = data.aws_iam_policy_document.external_dns_route_53.json
}
//Faz o attach da policy na role 
resource "aws_iam_role_policy_attachment" "external_dns_route53_policy" {
  policy_arn = aws_iam_policy.external_dns_route_53.arn
  role       = aws_iam_role.external_dns.name
}

