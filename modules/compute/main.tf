locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}

resource "aws_launch_template" "this" {
  name_prefix = "${var.name}-"

  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.security_group_id
  ]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${var.name}-app"
      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name}-launch-template"
    }
  )
}

resource "aws_autoscaling_group" "this" {
  name_prefix = "${var.name}-"

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [
    var.target_group_arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${var.name}-app"
      }
    )

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
