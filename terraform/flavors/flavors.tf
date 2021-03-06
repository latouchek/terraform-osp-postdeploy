# provider "openstack" {
#   user_name   = "redhat"
#   tenant_name = "redhat"
#   password    = "redhat"
#   auth_url    = "http://172.20.0.10:5000//v3"
# }
provider "openstack" {
  user_name = "${var.openstack_user_name}"
  tenant_name = "${var.openstack_tenant_name}"
  password  = "${var.openstack_password}"
  auth_url  = "${var.openstack_auth_url}"
  domain_name = "Default"
}


variable "flavorname" {
   type = "list"
   default = ["m1.tiny", "m1.small", "m1.medium", "m1.large", "m1.xlarge", "m1.xxlarge"]
 }
variable "flavorname2" {
  type = "list"
  default = ["epa.tiny", "epa.small", "epa.medium", "epa.large", "epa.xlarge", "epa.xxlarge"]
}
variable "ram" {
    type = "list"
    default = ["512", "2048", "4096", "8192", "16384", "32768"]
  }
variable "vcpu" {
    type = "list"
    default = ["1", "2", "4", "8", "12", "16"]
   }
variable "disk" {
    type = "list"
    default = ["1", "20", "40", "60", "80", "160"]
    }



resource "openstack_compute_flavor_v2" "flavorepa" {
  name  = "${element(var.flavorname2, count.index)}"
  ram   = "${element(var.ram, count.index)}"
  vcpus = "${element(var.vcpu, count.index)}"
  disk  = "${element(var.disk, count.index)}"
  is_public = "true"
  extra_specs = {
    "hw:cpu_policy" = "dedicated",
    "hw:cpu_thread_policy" = "isolate",
    "hw:mem_page_size" = "1048576",
    "hw:numa_mempolicy" = "strict",
    "epa"   = "true"
  }
  count = "${length(var.flavorname2)}"
}
