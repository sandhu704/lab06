output "iam_role_arn" {
  description = "The ARN of the IAM Role created for various resources."
  value       = aws_iam_role.iam_role.arn
}

output "iam_policy_arn" {
  description = "The ARN of the IAM Policy attached to the role."
  value       = aws_iam_policy.iam_policy.arn
}

output "iam_instance_profile_name" {
  description = "The name of the IAM Instance Profile associated with EC2 instances."
  value       = aws_iam_instance_profile.iam_profile.name
}

output "ec2_instance_id" {
  description = "The ID of the deployed EC2 instance."
  value       = aws_instance.instance.id
}

output "ec2_instance_public_ip" {
  description = "The public IP address of the deployed EC2 instance."
  value       = aws_instance.instance.public_ip
}

output "lambda_function_name" {
  description = "The name of the Lambda function deployed."
  value       = aws_lambda_function.lambda.function_name
}

output "security_group_id" {
  description = "The ID of the Security Group associated with the EC2 instance."
  value       = aws_security_group.sg.id
}
