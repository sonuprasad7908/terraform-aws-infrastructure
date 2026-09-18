variable "name" {
  description = "Name prefix used for security resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups are created"
  type        = string
}

variable "alb_ingress_cidrs" {
  description = "IPv4 CIDR blocks allowed to access the load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_ingress_ports" {
  description = "TCP ports exposed by the load balancer"
  type        = set(number)
  default     = [80, 443]

  validation {
    condition = alltrue([
      for port in var.alb_ingress_ports :
      port >= 1 && port <= 65535
    ])

    error_message = "All load balancer ports must be between 1 and 65535."
  }
}

variable "application_port" {
  description = "Port used by the application"
  type        = number
  default     = 3000

  validation {
    condition     = var.application_port >= 1 && var.application_port <= 65535
    error_message = "application_port must be between 1 and 65535."
  }
}

variable "tags" {
  description = "Additional tags applied to security resources"
  type        = map(string)
  default     = {}
}
