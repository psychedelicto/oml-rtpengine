# tags tags tags tags tags tags tags tags
# tags tags tags tags tags tags tags tags
resource "digitalocean_tag" "tenant" {
  name = var.tenant
}
resource "digitalocean_tag" "environment" {
  name = var.environment
}

# Lookup image to get id
data "digitalocean_image" "official" {
  count = var.custom_image == true ? 0 : 1
  slug  = var.image_name
}

#Module      : Droplet
#Description : Provides a DigitalOcean Droplet resource. This can be used to create, modify, and delete Droplets.
resource "digitalocean_droplet" "main" {
  image              = join("", data.digitalocean_image.official.*.id)
  name               = var.name
  region             = var.region
  size               = var.droplet_size
  backups            = var.backups
  monitoring         = var.monitoring
  private_networking = var.private_networking
  ssh_keys           = var.ssh_keys
  user_data          = var.user_data
  vpc_uuid           = var.vpc_uuid

  tags               = [
    digitalocean_tag.tenant.id,
    digitalocean_tag.environment.id
  ]
}

#Module     : Firewall for RTPENGINE
resource "digitalocean_firewall" "fw_rtpengine" {
  name = var.name_rtpengine

  droplet_ids = [module.droplet_rtpengine.id[0]]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol            = "tcp"
    port_range          = "22222"
    source_droplet_ids  = [module.droplet_omlapp.id[0]]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "20000-50000"
    source_addresses = ["0.0.0.0/0"]
  }


  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
  protocol              = "icmp"
  destination_addresses = ["0.0.0.0/0", "::/0"]
}
}
