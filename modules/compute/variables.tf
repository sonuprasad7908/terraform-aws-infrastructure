variable "name" {
  description = "Name prefix used for compute resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used by the EC2 Launch Template"
  type        = string

  validation {
    condition     = startswith(var.ami_id, "ami-")
    error_message = "ami_id must start with 'ami-'."
  }
}

variable "instance_type" {
  description = "EC2 instance type used by the Launch Template"
  type        = string
  default     = "t3.micro"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the Auto Scaling Group"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least two private subnet IDs must be provided."
  }
}

variable "security_group_id" {
  description = "Application security group attached to EC2 instances"
  type        = string
}

variable "target_group_arn" {
  description = "Application Load Balancer target group ARN"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1

  validation {
    condition     = var.min_size >= 0 && floor(var.min_size) == var.min_size
    error_message = "min_size must be a non-negative integer."
  }
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 2

  validation {
    condition     = var.desired_capacity >= 0 && floor(var.desired_capacity) == var.desired_capacity
    error_message = "desired_capacity must be a non-negative integer."
  }
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 3

  validation {
    condition     = var.max_size >= 1 && floor(var.max_size) == var.max_size
    error_message = "max_size must be a positive integer."
  }
}

variable "health_check_grace_period" {
  description = "Time in seconds before ELB health checks affect new instances"
  type        = number
  default     = 300

  validation {
    condition     = var.health_check_grace_period >= 0
    error_message = "health_check_grace_period must be zero or greater."
  }
}

variable "tags" {
  description = "Additional tags applied to compute resources"
  type        = map(string)
  default     = {}
}
