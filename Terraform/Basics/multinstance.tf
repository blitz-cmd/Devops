terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
resource "aws_instance" "Myfirstinstance"{
    count=3
    ami="ami-04db49c0fb2215364"
    instance_type="t2.micro"

    tags={
        Name="demoinstance-${count.index}"
    }
}