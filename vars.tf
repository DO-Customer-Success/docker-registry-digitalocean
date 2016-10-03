variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "region" {
  description = "DigitalOcean Region (Any region supporting Block Storage: NYC1,SGP1,SFO2)"
  default = "NYC1"
}
variable "common_name" {}
variable "vol_size" {
  description = "Size of the Registry Volume"
}
