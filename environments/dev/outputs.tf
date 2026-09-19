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
output "launch_template_id" {
  description = "Development EC2 Launch Template ID"
  value       = module.compute.launch_template_id
}

output "autoscaling_group_name" {
  description = "Development Auto Scaling Group name"
  value       = module.compute.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "Development Auto Scaling Group ARN"
  value       = module.compute.autoscaling_group_arn
}
