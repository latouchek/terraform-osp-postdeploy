variable "openstack_user_name" {}
variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}
# variable "image" {
#   default = "fedora27"
# }

# variable "flavor" {
#   default = "epa.small"
# }

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
	default = "allowall"
}

variable "network" {
	default  = "provider-subnet1"
}

variable "flavor" {
   type = "list"
   default = ["m2.small", "m2.large", "m2.small", "m2.small", "m2.small", "m2.large"]
 }
variable "ip" {
  type = "list"
  default = ["10.200.1.40", "10.200.1.41", "10.200.1.42", "10.200.1.43", "10.200.1.44", "10.200.1.45"]
}

variable "image" {
  type = "list"
  default = ["cirros", "Ubuntu18.04", "centos7", "Fedora29", "centos7", "Fedora29"]
}
variable "name" {
    type = "list"
    default = ["terratest", "terratest", "terratest", "terratest", "terratest", "terratest"]
  }
# variable "vcpu" {
#     type = "list"
#     default = ["1", "2", "4", "8", "12", "16"]
#    }
# variable "disk" {
#     type = "list"
#     default = ["1", "20", "40", "60", "80", "160"]
#     }
