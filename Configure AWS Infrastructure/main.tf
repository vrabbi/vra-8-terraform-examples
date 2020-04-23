#################################################################################
#################################################################################
######################### Provider Configuration ################################
#################################################################################
#################################################################################

provider "vra" {
  url           = var.url
  refresh_token = var.refresh_token
  insecure      = var.insecure // false for vRA Cloud and true for vRA 8.0
}

#################################################################################
#################################################################################
####################### Data Source Configurations ##############################
#################################################################################
#################################################################################

data "vra_region" "region_1" {
  cloud_account_id = vra_cloud_account_aws.this.id
  region           = "us-east-1"
}

data "vra_region" "region_2" {
  cloud_account_id = vra_cloud_account_aws.this.id
  region           = "eu-west-2"
}

data "vra_region" "region_3" {
  cloud_account_id = vra_cloud_account_aws.this.id
  region           = "eu-west-1"
}

#################################################################################
#################################################################################
######################## Resource Configurations ################################
#################################################################################
#################################################################################

####################################
####################################
########## Cloud Account ##########
####################################
####################################

resource "vra_cloud_account_aws" "this" {
  name        = "AWS Cloud Account"
  description = "example aws account"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
  regions     = ["us-east-1", "eu-west-2", "eu-west-1"]

  tags {
    key   = "cloud"
    value = "aws"
  }
}

####################################
####################################
########### Cloud Zones ############
####################################
####################################

resource "vra_zone" "aws_zone_1" {
  name        = "AWS Dev Zone"
  description = "aws development cloud zone"
  region_id   = data.vra_region.region_1.id

  tags {
    key   = "cloud"
    value = "aws"
  }

  tags {
    key   = "env"
    value = "dev"
  }
}

resource "vra_zone" "aws_zone_2" {
  name        = "AWS Production Zone"
  description = "aws production site cloud zone"
  region_id   = data.vra_region.region_2.id

  tags {
    key   = "cloud"
    value = "aws"
  }

  tags {
    key   = "env"
    value = "prod"
  }
}

resource "vra_zone" "aws_zone_3" {
  name        = "AWS DR Zone"
  description = "aws dr cloud zone"
  region_id   = data.vra_region.region_3.id

  tags {
    key   = "cloud"
    value = "aws"
  }

  tags {
    key   = "env"
    value = "dr"
  }
}