# ☁️ Terraform AWS Infrastructure

A modular AWS infrastructure reference project built with Terraform to demonstrate practical Cloud Engineering and Infrastructure as Code concepts.

The repository models a highly available web application architecture using reusable Terraform modules for networking, security, load balancing, and Auto Scaling compute.

> **Portfolio / reference implementation:** This repository is intentionally validated as code and does not automatically provision AWS resources.

---

## 🏗️ Architecture

```text
                         Internet
                            │
                            ▼
                 ┌─────────────────────┐
                 │ Application Load    │
                 │ Balancer            │
                 └──────────┬──────────┘
                            │
                            ▼
                    ┌──────────────┐
                    │ Target Group │
                    └──────┬───────┘
                           │
                           ▼
                ┌───────────────────────┐
                │ Auto Scaling Group    │
                │ EC2 App Instances     │
                └───────────┬───────────┘
                            │
                     Private Subnets
                            │
                    ┌───────┴────────┐
                    │      VPC       │
                    └────────────────┘
```

The infrastructure is distributed across multiple Availability Zones and separates internet-facing resources from private application resources.

---

## 🧩 Implemented Terraform Modules

### Network

Creates the core VPC networking layer.

Includes:

- VPC
- Public subnets
- Private subnets
- Multiple Availability Zones
- Internet Gateway
- Public route table
- Private route tables
- Optional NAT Gateway architecture
- Reusable networking outputs

### Security

Defines separate security boundaries for the load balancer and application layer.

Includes:

- Application Load Balancer security group
- Configurable HTTP/HTTPS ingress
- Application security group
- Application traffic allowed only from the ALB security group
- Explicit outbound rules
- Input validation
- Reusable security group outputs

### Load Balancer

Creates the internet-facing application entry point.

Includes:

- Application Load Balancer
- Public subnet integration
- ALB security group integration
- HTTP listener
- Application target group
- Configurable application port
- Configurable health check path
- Reusable ALB outputs

### Compute

Creates the scalable application compute layer.

Includes:

- EC2 Launch Template
- Auto Scaling Group
- Private subnet placement
- Application security group integration
- ALB target group attachment
- IMDSv2 enforcement
- Configurable instance type
- Configurable minimum, desired, and maximum capacity
- ELB health checks
- Reusable compute outputs

---

## 📁 Repository Structure

```text
terraform-aws-infrastructure/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── variables.tf
│
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── security/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── load-balancer/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── compute/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── .gitignore
└── README.md
```

---

## 🔗 Module Integration

The development environment connects the reusable modules together:

```text
network.vpc_id
      │
      ├──────────────► security
      │
      ├──────────────► load-balancer
      │
      └──────────────► compute

network.public_subnet_ids
      │
      └──────────────► load-balancer

network.private_subnet_ids
      │
      └──────────────► compute

security.alb_security_group_id
      │
      └──────────────► load-balancer

security.application_security_group_id
      │
      └──────────────► compute

load-balancer.target_group_arn
      │
      └──────────────► compute
```

This keeps individual infrastructure components reusable while the environment layer handles integration.

---

## 🔐 Security Design

The project follows practical infrastructure security principles:

- Application instances are placed in private subnets.
- The Application Load Balancer is placed in public subnets.
- Application instances do not accept application traffic directly from the internet.
- Application traffic is restricted to the ALB security group.
- EC2 Instance Metadata Service v2 is required.
- AWS credentials are not stored in the repository.
- Terraform state is excluded from Git.
- Infrastructure values are exposed through controlled module outputs.
- Variable validation is used for important configuration inputs.

---

## ⚙️ Development Environment

The example development environment currently models:

```text
Region: ap-south-1

VPC:
10.10.0.0/16

Public Subnets:
10.10.1.0/24
10.10.2.0/24

Private Subnets:
10.10.11.0/24
10.10.21.0/24

Availability Zones:
ap-south-1a
ap-south-1b

Application Port:
3000

ALB Listener:
HTTP :80

Auto Scaling:
Minimum: 1
Desired: 2
Maximum: 3
```

NAT Gateway creation is disabled in the development example to avoid unintentionally introducing chargeable infrastructure.

---

## 🧪 Local Validation

Initialize the development configuration:

```bash
terraform -chdir=environments/dev init -backend=false
```

Format the Terraform configuration:

```bash
terraform fmt -recursive
```

Check formatting:

```bash
terraform fmt -check -recursive
```

Validate the Terraform configuration:

```bash
terraform -chdir=environments/dev validate
```

The repository uses a validation-first workflow before infrastructure changes are merged.

---

## 🚫 Deployment Scope

This project intentionally does not automatically execute:

```bash
terraform apply
```

No AWS infrastructure is required to review the module design.

The repository is intended to demonstrate:

- Terraform module design
- Infrastructure composition
- AWS architecture knowledge
- Security group relationships
- Multi-AZ networking
- Load balancing
- Auto Scaling
- Infrastructure validation
- Git-based Cloud Engineering workflows

---

## 🛠️ Technologies

- Terraform
- AWS
- Amazon VPC
- Amazon EC2
- EC2 Auto Scaling
- Application Load Balancer
- Security Groups
- Linux
- Git
- GitHub
- Infrastructure as Code

---

## 📌 Project Roadmap

- [x] Create Terraform project foundation
- [x] Build reusable VPC networking module
- [x] Add reusable security group module
- [x] Add Application Load Balancer module
- [x] Add EC2 Launch Template and Auto Scaling module
- [x] Configure development environment
- [x] Add reusable Terraform outputs
- [x] Add input validation
- [x] Document infrastructure architecture
- [x] Add automated Terraform CI validation
- [ ] Add additional architecture documentation

---

## 🎯 What This Project Demonstrates

This project demonstrates the ability to structure Terraform code for reusable AWS infrastructure rather than placing all resources in a single configuration.

It focuses on Cloud Engineering responsibilities such as:

- AWS infrastructure design
- Networking and subnet architecture
- Security group configuration
- Load balancing
- Auto Scaling
- Terraform module development
- Infrastructure validation
- Git-based change management

---

## 👨‍💻 Author

**Sonu Kumar Prasad**

Cloud Engineer focused on AWS, Linux, Terraform, Docker, CI/CD, networking, and infrastructure automation.
