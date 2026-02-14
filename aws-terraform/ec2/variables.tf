variable "ami_id" {
  type = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_name" {
  type    = string
  default = "Jumpvm-db-eks"
}

variable "key_name" {
  type = string
}