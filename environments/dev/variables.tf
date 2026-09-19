variable "aws_region" {
  description = "AWS region used by the development environment"
  type        = string
  default     = "ap-south-1"
}
variable "compute_ami_id" {
  description = "AMI ID used by the development compute module"
  type        = string
}
