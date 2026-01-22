terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.60"
    }
  }
}

provider "huaweicloud" {
  region     = "af-south-1"
  access_key = "HPUAXCFFYGSZ9NWZYZB8"
  secret_key = "NbZSIoVWrOZIOLbgBQEHDp8TPKnrNZQk8l4kahdZ"
}

# Subnet
resource "huaweicloud_vpc_subnet" "subnet" {
  name       = "subnet-github-actions"
  cidr       = "192.168.3.0/24"
  gateway_ip = "192.168.3.1"
  vpc_id     = "188d88f0-1547-4335-9480-26aec4cc61d0"
}

# Security Group
resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = "secgroup-github-actions"
  description = "Security group for nginx ECS"
}

# Security Group Rules
resource "huaweicloud_networking_secgroup_rule" "allow_ssh" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "allow_http" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 80
  port_range_max   = 80
  remote_ip_prefix = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "allow_https" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 443
  port_range_max   = 443
  remote_ip_prefix = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "allow_nestjs" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3000
  port_range_max    = 3000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}

# Get Ubuntu Image
data "huaweicloud_images_image" "ubuntu" {
  name        = "Ubuntu 22.04 server 64bit"
  most_recent = true
}

# SSH Key Pair
resource "huaweicloud_compute_keypair" "keypair" {
  name = "huawei-keypair"
}

# ECS Instance
resource "huaweicloud_compute_instance" "ecs" {
  name               = "nginx-ecs-ubuntu"
  image_id           = data.huaweicloud_images_image.ubuntu.id
  flavor_id          = "s6.small.1"
  security_group_ids = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone  = "af-south-1a"
  key_pair           = huaweicloud_compute_keypair.keypair.name

  network {
    uuid = huaweicloud_vpc_subnet.subnet.id
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y nginx git
              systemctl start nginx
              systemctl enable nginx
              EOF
}

# Elastic IP
resource "huaweicloud_vpc_eip" "eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "bandwidth-github-actions"
    size        = 5
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# Associate EIP with ECS
resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.eip.address
  instance_id = huaweicloud_compute_instance.ecs.id
}

# Outputs
output "public_ip" {
  value = huaweicloud_vpc_eip.eip.address
}

output "private_ip" {
  value = huaweicloud_compute_instance.ecs.access_ip_v4
}


