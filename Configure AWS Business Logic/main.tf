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

data "vra_cloud_account_aws" "this" {
  name = "AWS Cloud Account"
}


data "vra_region" "region_1" {
  cloud_account_id = data.vra_cloud_account_aws.this.id
  region           = "us-east-1"
}

data "vra_region" "region_2" {
  cloud_account_id = data.vra_cloud_account_aws.this.id
  region           = "eu-west-2"
}

data "vra_region" "region_3" {
  cloud_account_id = data.vra_cloud_account_aws.this.id
  region           = "eu-west-1"
}

#################################################################################
#################################################################################
######################## Resource Configurations ################################
#################################################################################
#################################################################################

resource "vra_image_profile" "aws_images_region_1" {
  name = "demo-img-aws-region-1"
  description = "Demo image mapping created by Terraform"

  region_id = data.vra_region.region_1.id
  image_mapping {
    name =       "ubuntu18"
    image_name = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20171026.1"
  }
  image_mapping {
    name =       "ubuntu16"
    image_name = "ami-ubuntu-16.04-1.10.3-00-1526923973"
  }
  image_mapping {
    name =       "centos7"
    image_name = "CentOS 7.7.1908 x86_64 with cloud-init (HVM)"
  }
  image_mapping {
    name =       "windows2016"
    image_name = "base-windows2016-25092017"
  }
}

resource "vra_image_profile" "aws_images_region_2" {
  name = "demo-img-aws-region-2"
  description = "Demo image mapping created by Terraform"

  region_id = data.vra_region.region_2.id
  image_mapping {
    name =       "ubuntu18"
    image_name = "ami-ubuntu-18.04-1.11.3-00-1555976447"
  }
  image_mapping {
    name =       "ubuntu16"
    image_name = "ami-ubuntu-16.04-1.10.3-00-1526923973"
  }
  image_mapping {
    name =       "centos7"
    image_name = "CentOS 7.7.1908 x86_64 with cloud-init (HVM)"
  }
  image_mapping {
    name =       "windows2016"
    image_name = "base-windows2016-25092017"
  }
}

resource "vra_image_profile" "aws_images_region_3" {
  name = "demo-img-aws-region-3"
  description = "Demo image mapping created by Terraform"

  region_id = data.vra_region.region_3.id
  image_mapping {
    name =       "ubuntu18"
    image_name = "ami-ubuntu-18.04-1.11.3-00-1555976447"
  }
  image_mapping {
    name =       "ubuntu16"
    image_name = "ami-ubuntu-16.04-1.10.3-00-1526923973"
  }
  image_mapping {
    name =       "centos7"
    image_name = "CentOS 7.7.1908 x86_64 with cloud-init (HVM)"
  }
  image_mapping {
    name =       "windows2016"
    image_name = "base-windows2016-25092017"
  }
}

####################################
####################################
######### Flavor Profiles ##########
####################################
####################################

resource "vra_flavor_profile" "aws_dev" {
  name        = "aws dev flavor profile"
  description = "Flavor profile created by Terraform"
  region_id   = data.vra_region.region_1.id

  flavor_mapping {
    name          = "small"
    instance_type = "t2.small"
  }
  flavor_mapping {
    name          = "medium"
    instance_type = "t2.medium"
  }

  flavor_mapping {
    name          = "large"
    instance_type = "t2.large"
  }
}

resource "vra_flavor_profile" "aws_prod" {
  name        = "aws production flavor profile"
  description = "Flavor profile created by Terraform"
  region_id   = data.vra_region.region_2.id

  flavor_mapping {
    name          = "small"
    instance_type = "t2.small"
  }
  flavor_mapping {
    name          = "medium"
    instance_type = "t2.medium"
  }
  flavor_mapping {
    name          = "large"
    instance_type = "t2.large"
  }
}

resource "vra_flavor_profile" "aws_dr" {
  name        = "aws dr flavor profile"
  description = "Flavor profile created by Terraform"
  region_id   = data.vra_region.region_3.id

  flavor_mapping {
    name          = "small"
    instance_type = "t2.small"
  }
  flavor_mapping {
    name          = "medium"
    instance_type = "t2.medium"
  }

  flavor_mapping {
    name          = "large"
    instance_type = "t2.large"
  }
}