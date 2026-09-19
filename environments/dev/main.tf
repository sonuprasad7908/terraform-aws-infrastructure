module "network" {
  source = "../../modules/network"

  name     = "portfolio-dev"
  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.21.0/24"
  ]

  # Disabled so this portfolio project never creates chargeable
  # NAT Gateways unless explicitly enabled by a user.
  enable_nat_gateway = false

  tags = {
    Project     = "terraform-aws-infrastructure"
    Environment = "development"
  }
}
module "security" {
  source = "../../modules/security"

  name   = "portfolio-dev"
  vpc_id = module.network.vpc_id

  alb_ingress_cidrs = [
    "0.0.0.0/0"
  ]

  alb_ingress_ports = [
    80,
    443
  ]

  application_port = 3000

  tags = {
    Project     = "terraform-aws-infrastructure"
    Environment = "development"
  }
}
module "load_balancer" {
  source = "../../modules/load-balancer"

  name   = "portfolio-dev"
  vpc_id = module.network.vpc_id

  public_subnet_ids = values(module.network.public_subnet_ids)

  security_group_ids = [
    module.security.alb_security_group_id
  ]

  listener_port     = 80
  application_port  = 3000
  health_check_path = "/health"

  tags = {
    Project     = "terraform-aws-infrastructure"
    Environment = "development"
  }
}
module "compute" {
  source = "../../modules/compute"

  name          = "portfolio-dev"
  ami_id        = var.compute_ami_id
  instance_type = "t3.micro"

  private_subnet_ids = values(module.network.private_subnet_ids)

  security_group_id = module.security.application_security_group_id
  target_group_arn  = module.load_balancer.target_group_arn

  min_size         = 1
  desired_capacity = 2
  max_size         = 3

  health_check_grace_period = 300

  tags = {
    Project     = "terraform-aws-infrastructure"
    Environment = "development"
  }
}
