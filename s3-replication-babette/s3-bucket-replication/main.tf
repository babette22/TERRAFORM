# ... other configuration ...

resource "aws_s3_bucket" "s3_bucket_east1" {
  provider = aws.main-bucket
  bucket   = format("%s-s3-bucket-east1", var.common_tags["id"])
}

resource "aws_s3_bucket_versioning" "s3_bucket_east1" {
  bucket = aws_s3_bucket.s3_bucket_east1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3_bucket_east2" {
  provider = aws.backup-bucket
  bucket   = format("%s-s3-bucket-east2", var.common_tags["id"])
}

resource "aws_s3_bucket_versioning" "s3_bucket_east2" {
  provider = aws.backup-bucket

  bucket = aws_s3_bucket.s3_bucket_east2.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "east1_to_east2" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.s3_bucket_east1]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.s3_bucket_east1.id

  rule {
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.s3_bucket_east2.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_replication_configuration" "east2_to_east1" {
  provider = aws.backup-bucket
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.s3_bucket_east2]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.s3_bucket_east2.id

  rule {

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.s3_bucket_east1.arn
      storage_class = "STANDARD"
    }
  }
}