terraform {
  backend "s3" {
    bucket = "fil-rouge-backend"
    key = "jenkins-prod.tfstate"
    region = "us-east-1"
  }
}
