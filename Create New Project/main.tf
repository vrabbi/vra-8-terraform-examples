provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = true
}

data "vra_zone" "aws_cloud_zone_1" {
  name = var.aws_cloud_zone_1
}

data "vra_zone" "aws_cloud_zone_2" {
  name = var.aws_cloud_zone_2
}

data "vra_zone" "aws_cloud_zone_3" {
  name = var.aws_cloud_zone_3
}

resource "vra_project" "example" {
  name        = var.project_name
  description = var.project_description
  zone_assignments {
    zone_id       = data.vra_zone.aws_cloud_zone_1.id
    priority      = var.aws_zone_1_priority
    max_instances = var.aws_zone_1_max_vms
  }
  zone_assignments {
    zone_id       = data.vra_zone.aws_cloud_zone_2.id
    priority      = var.aws_zone_2_priority
    max_instances = var.aws_zone_2_max_vms
  }
  zone_assignments {
    zone_id       = data.vra_zone.aws_cloud_zone_3.id
    priority      = var.aws_zone_3_priority
    max_instances = var.aws_zone_3_max_vms
  }
  administrators = var.project_admins
  members = var.project_users
}