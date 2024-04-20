
 resource "aws_iam_role" "iam_role" {
  name = var.iam_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = ["ec2.amazonaws.com", "lambda.amazonaws.com"]
        }
      },
    ]
  })
}



resource "aws_iam_policy" "iam_policy" {
  name        = var.iam_policy

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:ModifyInstanceAttribute"
        ],
        Effect = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "extra_permissions" {
  name = "extra_permissions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:CreateInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:PassRole",
          "events:PutRule",
          "events:DeleteRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "events:DescribeRule"
        ],
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_role_policy_attachment" "extra_permissions_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.extra_permissions.arn
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = var.iam_profile
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_policy" "lambda_ec2_sg_policy" {
  name        = "LambdaEC2SecurityGroupPolicy"
  description = "Allows Lambda to manage EC2 and security groups"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_sg_policy_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.lambda_ec2_sg_policy.arn
}
