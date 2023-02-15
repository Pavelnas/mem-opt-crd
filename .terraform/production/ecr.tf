resource "aws_ecr_repository" "rails-prod-ecr" {
  name                 = "rails-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}