#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {}

variable "droplet_enabled" {
  type        = bool
  default     = true
  description = "Flag to control the droplet creation."
}

variable "region" {}

variable "backups" {
  type        = bool
  default     = false
  description = "Boolean controlling if backups are made. Defaults to false."
}

variable "droplet_size" {
  type        = string
  default     = "micro"
  description = "the size slug of a droplet size"
}

variable "floating_ip" {
  type        = bool
  default     = false
  description = "(Optional) Boolean to control whether floating IPs should be created."
}

variable "floating_ip_assign" {
  type        = bool
  default     = true
  description = "(Optional) Boolean controlling whether floatin IPs should be assigned to instances with Terraform."
}

variable "image_id" {
  type        = string
  default     = ""
  description = "The id of an image to use."
}

variable "image_name" {
  type        = string
  description = "The image name or slug to lookup."
  default     = "ubuntu-18-04-x64"
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "(Optional) Boolean controlling whether monitoring agent is installed. Defaults to false."
}

variable "private_networking" {
  type        = bool
  default     = false
  description = "(Optional) Boolean controlling if private networks are enabled. Defaults to false."
}

variable "ssh_keys" {
  type        = list
  default     = []
  description = "(Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. To retrieve this info, use a tool such as curl with the DigitalOcean API, to retrieve them."
}

variable "user_data" {
  type        = string
  default     = ""
  description = "(Optional) A string of the desired User Data for the Droplet."
}

variable "vpc_uuid" {
  type        = string
  default     = ""
  description = "The ID of the VPC where the Droplet will be located."
}

variable "tenant" {
  type        = string
  default     = ""
  description = "The tenant tag"
}

variable "environment" {
  type        = string
  default     = ""
  description = "The environment tag"
}
