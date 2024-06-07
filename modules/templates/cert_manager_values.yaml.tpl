installCRDs: true
serviceAccount:
  create: true
  name: ${serviceAccountname}
  annotations:
    eks.amazonaws.com/role-arn: ${role}
