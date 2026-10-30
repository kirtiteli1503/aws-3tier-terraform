## Progress log
- Day 1: Repo setup, AWS CLI connected, manual VPC build
- Day 2: Terraform VPC module with s3 remote state applied, verified, and destroyed
- Day 3: Added security groups, ECR and ALB modules. ALB returns 503 as expected (no targets yet)
[main 43abbd5] Add security groups, ECR and ALB modules. ALB returns 503 as expected (no targets yet)
 14 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 docs/alb.png
 create mode 100644 docs/curl-503.png
 create mode 100644 terraform/modules/alb/main.tf
 create mode 100644 terraform/modules/alb/outputs.tf
 create mode 100644 terraform/modules/alb/variables.tf
 create mode 100644 terraform/modules/ecr/main.tf
 create mode 100644 terraform/modules/ecr/outputs.tf
 create mode 100644 terraform/modules/ecr/variales.tf
 create mode 100644 terraform/modules/security/main.tf
 create mode 100644 terraform/modules/security/outputs.tf
 create mode 100644 terraform/modules/security/variables.tf
