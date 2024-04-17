terraform {
  backend "s3" {
    bucket = "fil-rouge-backend"
    key = "jenkins-staging.tfstate"
    region = "us-east-1"
  }
}
