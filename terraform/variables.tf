variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID (replace with a valid Amazon Linux AMI for your region before a real apply)"
  type        = string
  default     = "ami-0123456789abcdef0"
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH into the instance"
  type        = string
  default     = "0.0.0.0/0"
}

variable "offline_validation" {
  description = "Skip AWS credential/account checks so plan works without an AWS account"
  type        = bool
  default     = false
}
