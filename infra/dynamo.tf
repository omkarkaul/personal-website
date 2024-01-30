resource "aws_dynamodb_table" "blog_posts_table" {
  name = "BlogPosts"
  hash_key = "PostId"
  range_key = "Date"

  attribute {
    name = "PostId"
    type = "N"
  }

  attribute {
    name = "Date"
    type = "N"
  }

  deletion_protection_enabled = true
  billing_mode = "PAY_PER_REQUEST"
}