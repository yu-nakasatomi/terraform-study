terraform {
  backend "s3" {
    bucket = "nakasatomi-terraform"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    profile= "kagDevCamp"
  }
}