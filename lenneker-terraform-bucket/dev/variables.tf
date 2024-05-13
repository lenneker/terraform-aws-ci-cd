 variable "region" {
    type = string
    default ="us-east-1"
    description = "AWS Region"
 }

 variable "environment" {
    type = string
    default = "dev"
 }

 variable "container_port" {
   type = number
   default = 3000
 }

variable "s3-bucket" {
   type = string
   default = "lenneker-terraform-bucket"
}
