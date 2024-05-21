# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.public.zone_id
#   name    = var.r53_public_zone_domain
#   type    = "A"
#
#   alias {
#     name                   = data.aws_lb.argocd_ingress.dns_name
#     zone_id                = data.aws_lb.argocd_ingress.zone_id
#     evaluate_target_health = true
#   }
# }
