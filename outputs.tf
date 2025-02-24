output "instance_public_ip" {
  value       = aws_instance.web.public_ip
}

output "aws_account_alias" {
  value       = data.aws_iam_account_alias.current.account_alias
}
