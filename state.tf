terraform {
  backend "s3" {
    bucket   = "aiml-tf-state-bucket"
    key      = "lakeformateion-ingest.tfstate"
    region   = "eu-central-1"
  }
}
