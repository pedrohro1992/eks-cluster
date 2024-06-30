provider:
  name: aws
env:
  - name: AWS_DEFAULT_REGION
    value: ${region}
serviceAccount:
  create: true
  name: ${serviceAccountname}
  annotations:
    eks.amazonaws.com/role-arn: ${role}
