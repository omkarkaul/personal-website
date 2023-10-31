resource "aws_iam_user" "personal_website_user" {
  name = "personal_website_user"
}

resource "aws_iam_user_policy_attachment" "global_admin_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  user       = "GlobalAdmin"
}

resource "aws_iam_user_policy_attachment" "s3_access_policy_attachment" {
  policy_arn = aws_iam_policy.personal_website_user_s3_access_policy.arn
  user       = aws_iam_user.personal_website_user.name
}

resource "aws_iam_policy" "personal_website_user_s3_access_policy" {
  name        = "personalWebsiteUserReadPolicy"
  description = "Policy to allow read access to Q&A bucket"
  policy      = data.aws_iam_policy_document.qna_bucket_get_objects.json
}

data "aws_iam_policy_document" "qna_bucket_get_objects" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [aws_s3_bucket.qna_bucket.arn]
  }
}
