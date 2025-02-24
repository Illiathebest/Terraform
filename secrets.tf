data "aws_secretsmanager_secret" "existing_secret" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "existing_secret_version" {
  secret_id = data.aws_secretsmanager_secret.existing_secret.id
}

locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.existing_secret_version.secret_string)
}
