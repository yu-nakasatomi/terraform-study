########################################
# デモの手順
# 1. まずそのまま terraform plan / apply をしてバケットが作成されることを確認する
# 2. L16~17の値をtrueに変え、L20以降をコメントインしてplanを実行 --> 差分が出ることを確認
# 3. applyして、S3のパブリックアクセスブロックの設定が変わっていることを確認
# 4. index.htmlがバケットに作成されていること、バケットポリシーが設定されていること、ホスティングが設定されていることを確認      
########################################

resource "aws_s3_bucket" "sample" {
  bucket = "sample-bucket-${var.name}"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.sample.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.sample.id
  key = "index.html"
  source = "./src/index.html"
  etag = filemd5("./src/index.html")
  content_type = "text/html; charset=utf-8"
  lifecycle {
    ignore_changes = [
      etag
    ]
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.sample.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Test",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::sample-bucket-${var.name}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.sample.id
  index_document {
    suffix = "index.html"
  }
}