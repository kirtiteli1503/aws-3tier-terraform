variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "enable_nat_gateway" {
  description = "NAT costs money. Keep false until needed."
  type        = bool
  default     = false
}
