terraform {
  backend "s3" {
    bucket = "fil-rouge-backend"
    key = "jenkins2-staging.tfstate"
    region = "us-east-1"
  }
}
