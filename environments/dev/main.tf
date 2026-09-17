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
