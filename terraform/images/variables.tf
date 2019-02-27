variable "openstack_user_name" {}
variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}


variable "images" {
  type    = "map"
  default = {
    "Centos7" = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
    "Fedora29" = "https://download.fedoraproject.org/pub/fedora/linux/releases/29/Cloud/x86_64/images/Fedora-Cloud-Base-29-1.2.x86_64.qcow2"
    "Ubuntu18.04" = "http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
  }
}
