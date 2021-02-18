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
  #count = var.custom_image == true ? 0 : 1
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
  vpc_uuid           = var.vpc_uuid
  user_data          = templatefile("./user_data.tpl", {
  })

  tags               = [
    digitalocean_tag.tenant.id,
    digitalocean_tag.environment.id
  ]
}
