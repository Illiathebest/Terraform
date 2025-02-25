output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "my_test_password" {
  value       = jsondecode(aws_secretsmanager_secret_version.my_test_secret_version.secret_string).password
  sensitive   = true
}