output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = {
    for az, subnet in aws_subnet.public :
    az => subnet.id
  }
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value = {
    for az, subnet in aws_subnet.private :
    az => subnet.id
  }
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs of private route tables"
  value = {
    for az, route_table in aws_route_table.private :
    az => route_table.id
  }
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways when enabled"
  value = {
    for az, nat_gateway in aws_nat_gateway.this :
    az => nat_gateway.id
  }
}
