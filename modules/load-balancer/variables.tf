variable "name" {
  description = "Name prefix used for load balancer resources"
  type        = string

  validation {
    condition     = length(var.name) <= 28
    error_message = "name must be 28 characters or fewer so generated AWS resource names remain within their limits."
  }
}

variable "vpc_id" {
  description = "ID of the VPC where the target group is created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the Application Load Balancer"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "At least two public subnet IDs must be provided."
  }
}

variable "security_group_ids" {
  description = "Security group IDs attached to the Application Load Balancer"
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) >= 1
    error_message = "At least one security group ID must be provided."
  }
}

variable "listener_port" {
  description = "HTTP listener port exposed by the Application Load Balancer"
  type        = number
  default     = 80

  validation {
    condition = (
      var.listener_port >= 1 &&
      var.listener_port <= 65535 &&
      floor(var.listener_port) == var.listener_port
    )

    error_message = "listener_port must be an integer between 1 and 65535."
  }
}

variable "application_port" {
  description = "Port used by the backend application"
  type        = number
  default     = 3000

  validation {
    condition = (
      var.application_port >= 1 &&
      var.application_port <= 65535 &&
      floor(var.application_port) == var.application_port
    )

    error_message = "application_port must be an integer between 1 and 65535."
  }
}

variable "health_check_path" {
  description = "HTTP path used by the target group health check"
  type        = string
  default     = "/health"

  validation {
    condition     = startswith(var.health_check_path, "/")
    error_message = "health_check_path must start with '/'."
  }
}

variable "tags" {
  description = "Additional tags applied to load balancer resources"
  type        = map(string)
  default     = {}
}
