resource "random_password" "secret_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "my_test_secret" {
  name        = "my-test-secret-unique"
}

resource "aws_secretsmanager_secret_version" "my_test_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_test_secret.id
  secret_string = jsonencode({
    password = random_password.secret_password.result
  })
}