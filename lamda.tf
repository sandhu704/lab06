resource "aws_lambda_function" "lambda" {
  function_name = "UpdateSecurityGroupForSSH"
  handler       = "lambda_function.lambda_handler"  
  role          = aws_iam_role.iam_role.arn         
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  filename         = "${path.module}/lambda_function.zip"
}

resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "EC2InstanceStateChangeToRunning"
  description = "Triggers when an EC2 instance transitions to the 'running' state."

  event_pattern = jsonencode({
    source = ["aws.ec2"],
    "detail-type" = ["EC2 Instance State-change Notification"],
    detail = {
      state = ["running"]
    }
  })
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "InvokeLambdaForEC2Running"
  arn       = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke_lambda" {
  statement_id  = "AllowCloudWatchToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_state_change.arn
}
