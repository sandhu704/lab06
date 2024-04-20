variable "iam_role" {
  description = "The name of the IAM role to be used by AWS resources."
  default     = "iam_role"
}

variable "iam_policy" {
  description = "The identifier of the IAM policy that allows EC2 modifications based on CloudWatch events."
  default     = "iam_policy"
}

variable "iam_profile" {
  description = "The name of the IAM instance profile associated with the EC2 instance."
  default     = "iam_profile_1"
}

variable "ami" {
  description = "The AMI ID to be used for the EC2 instances."
  default     = "ami-032346ab877c418af"
}

variable "instance_type" {
  description = "The type of EC2 instance to be provisioned."
  default     = "t2.micro"
}

variable "aws_sg" {
  description = "The ID of the AWS security group to be associated with the EC2 instance."
  default     = "aws_sg"
}
