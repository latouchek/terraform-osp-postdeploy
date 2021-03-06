variable "openstack_user_name" {}
variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}
variable "image" {
  default = "centos7"
}

variable "flavor" {
  default = "epa.small"
}

variable "ssh_key_pair" {
  default = "undercloud-key"
}

variable "ssh_user_name" {
  default = "root"
}

variable "availability_zone" {
	default = "nova"
}

variable "security_group" {
	default = "default"
}

variable "network" {
	default  = "sriov"
}
