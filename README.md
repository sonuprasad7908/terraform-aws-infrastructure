# ☁️ Terraform AWS Infrastructure

A hands-on Cloud Engineering portfolio project demonstrating modular AWS infrastructure design using Terraform.

The project focuses on Infrastructure as Code structure, reusable modules, networking, security, compute, load balancing, environment configuration, and automated Terraform validation.

> This repository does not provision live AWS resources. Infrastructure code is validated locally and through CI without running `terraform apply`.

## 🎯 Project Goal

Design a reusable AWS infrastructure architecture using Terraform while following practical Cloud Engineering principles.

## 🏗️ Planned Architecture

```text
AWS
│
├── VPC
│   ├── Public Subnets
│   ├── Private Subnets
│   ├── Internet Gateway
│   ├── Route Tables
│   └── NAT Architecture
│
├── Security Groups
│   ├── Load Balancer
│   └── Application
│
├── Application Compute
│
├── Application Load Balancer
│   └── Target Group
│
└── Environment Configuration
    └── Development
```

## 📁 Planned Structure

```text
terraform-aws-infrastructure/
├── modules/
│   ├── network/
│   ├── security/
│   ├── compute/
│   └── load-balancer/
│
├── environments/
│   └── dev/
│
├── docs/
├── .gitignore
└── README.md
```

## 🛠️ Technologies

- Terraform
- AWS
- VPC
- EC2
- Application Load Balancer
- Security Groups
- Linux
- GitHub Actions
- Infrastructure as Code

## 📌 Project Roadmap

- [ ] Create Terraform project foundation
- [ ] Build reusable VPC networking module
- [ ] Add security group module
- [ ] Add application compute module
- [ ] Add Application Load Balancer module
- [ ] Configure development environment
- [ ] Add Terraform outputs
- [ ] Add variable validation
- [ ] Add automated Terraform CI validation
- [ ] Document infrastructure architecture

## 🔐 Security Principles

- No AWS credentials committed
- No Terraform state committed
- No production account information
- Least-privilege security group design
- Private application resources where appropriate
- Explicit variables and outputs
- Terraform formatting and validation before merge

## 🚫 Deployment Scope

This repository intentionally does not run:

```bash
terraform apply
```

The infrastructure is designed and validated as code without creating paid AWS resources.

## 🚧 Current Status

**Phase 1 — Terraform project foundation**
