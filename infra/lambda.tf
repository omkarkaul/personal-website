data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda/read.py"
  output_path = "lambda/read.zip"
}

resource "aws_lambda_function" "read_posts_lambda" {
  filename      = "${path.module}/lambda/read.zip"
  function_name = "read_posts_lambda"
  role          = aws_iam_role.posts_lambda_role.arn
  handler       = "read.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"
}