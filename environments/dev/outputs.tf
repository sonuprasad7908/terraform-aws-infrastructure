output "vpc_id" {
  description = "Development VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Development public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Development private subnet IDs"
  value       = module.network.private_subnet_ids
}
output "alb_security_group_id" {
  description = "Development application load balancer security group ID"
  value       = module.security.alb_security_group_id
}

output "application_security_group_id" {
  description = "Development application security group ID"
  value       = module.security.application_security_group_id
}
output "alb_dns_name" {
  description = "Development Application Load Balancer DNS name"
  value       = module.load_balancer.dns_name
}

output "alb_arn" {
  description = "Development Application Load Balancer ARN"
  value       = module.load_balancer.load_balancer_arn
}

output "target_group_arn" {
  description = "Development application target group ARN"
  value       = module.load_balancer.target_group_arn
}
