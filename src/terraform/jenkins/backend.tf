terraform {
  backend "s3" {
    bucket = "fil-rouge-backend"
    key = "jenkins.tfstate"
    region = "us-east-1"
  }
}
