

terraform {
  backend "s3" {
    bucket  = ""
    key     = "states/prd"
    region  = "us-east-1"
    profile = ""  
  }
}
