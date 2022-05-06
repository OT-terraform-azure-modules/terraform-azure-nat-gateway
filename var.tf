variable "nat_gtw_name" {
  type        = string
  description = "(Required) Name of our NAT Gateway"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the resource group. This we will get from another module"
}

variable "location" {
  type        = string
  description = "(Required) Location of NAT gateway"
}

variable "pub_ip_id" {
  type        = list
  description = "(Optional) ID of Public IP. This we will get from other module."
  default = []
}

variable "pub_ip_prefix_id" {
  type        = list
  description = "(Optional) ID of Public IP prefix."
  default = []
}

variable "sku_name" {
  type        = string
  description = "(Required) SKU."
  default     = "Standard"
}

variable "idle_timeout_mins" {
  type        = string
  description = "(Optional) The idle timeout which should be used in minutes.The value must be between 4 and 120."
  default = 4
}

variable "availability_zone" {
  type        = list(any)
  description = "(Required) availability zone where the NAT Gateway will be provisioned."
  default = []
}