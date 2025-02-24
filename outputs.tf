output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
