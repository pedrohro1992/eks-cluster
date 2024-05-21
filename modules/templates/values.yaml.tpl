controller:
  service:
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-type: alb
      service.beta.kubernetes.io/aws-load-balancer-additional-resource-tags: "load-balance-name=argocd-${cluster_name}"
