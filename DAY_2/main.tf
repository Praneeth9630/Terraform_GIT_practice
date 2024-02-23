provider "aws" {
  
}


resource "aws_s3_bucket" "name" {
  bucket = "praneeth123"
}
resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
  
}