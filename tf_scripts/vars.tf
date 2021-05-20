variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "S3BUCKET" {}
variable "AWS_USERID" {}

variable "AWS_REGION" {
  default = "eu-east-1"
}

variable "MYSQL_USERNAME" {
  default = "exampleuser"
}
variable "MYSQL_PASSWORD" {
  default = "examplepass"
}
variable "MYSQL_DB" {
  default = "ebdb"
}
variable "SSH_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}


