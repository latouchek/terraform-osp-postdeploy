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
resource "openstack_identity_project_v3" "tenant1" {
  name = "redhat"
}

resource "openstack_identity_user_v3" "user_1" {
  default_project_id = "${openstack_identity_project_v3.tenant1.id}"
  name = "redhat"
  description = "first user"

  password = "redhat"

  ignore_change_password_upon_first_use = true
}
resource "openstack_identity_role_v3" "role_1" {
  name = "role_1"
}
# resource "openstack_identity_role_assignment_v3" "role_assignment_1" {
#   user_id = "redhat"
#   project_id = "redhat"
#   role_id = "${openstack_identity_role_v3.role_1.id}"
# }
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name        = "allowall"
  description = "OpenBar"

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }
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

# resource "openstack_images_image_v2" "rancheros" {
#   name   = "RancherOS"
#   image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
#   container_format = "bare"
#   disk_format = "raw"
#
#   properties = {
#     key = "value"
#   }
# }

resource "openstack_images_image_v2" "CentOS7" {
  name   = "centos7"
  image_source_url = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  container_format = "bare"
  disk_format = "qcow2"

  properties = {
    key = "value"
  }
}
resource "openstack_compute_flavor_v2" "flavorsetm1" {
  name  = "${element(var.flavorname, count.index)}"
  ram   = "${element(var.ram, count.index)}"
  vcpus = "${element(var.vcpu, count.index)}"
  disk  = "${element(var.disk, count.index)}"
  is_public = "true"
  extra_specs = {
    "epa"   = "false"
  }
  count = "${length(var.flavorname)}"
}
resource "openstack_compute_flavor_v2" "flavorsetepa" {
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
# resource "openstack_networking_port_v2" "vf2" {
#   name = "vf2"
#   network_id = "b4053371-c9cd-457b-844a-486b301eec4c"
#   admin_state_up     = "true"
#   security_group_ids = ["378a0ede-f956-42bf-b232-68d96a25c29e"]
#   fixed_ip {
#     "subnet_id"  = "05092f11-298c-4e69-9a60-3e581447397e"
#     "ip_address" = "172.22.26.135"
#   }
# }
# resource "openstack_networking_port_v2" "port_1" {
#   name       = "vf3"
#   network_id = "5d46feeb-a9e6-4088-8e6b-28661366b661"
# }
resource "openstack_compute_instance_v2" "vm1" {
  count = "1"
  name = "test-instance"
  image_name = "${var.image}"
  # availability_zone = "${var.availability_zone}"
  flavor_name = "${var.flavor}"
  key_pair = "${var.ssh_key_pair}"
  # key_pair = "${file("key.pub")}"
  security_groups = ["${var.security_group}"]
  network {
    name = "telenor-net"
  }
  user_data = "${file("user-data")}"
}
resource "openstack_compute_instance_v2" "vm2" {
  count = "1"
  name = "test-instance2"
  image_name = "${var.image}"
  # availability_zone = "${var.availability_zone}"
  flavor_name = "m1.small"
  key_pair = "${var.ssh_key_pair}"
  # key_pair = "${file("key.pub")}"
  security_groups = ["${var.security_group}"]
  network {
    name = "telenor-net"
  }
  user_data = "${file("user-data")}"
}
# resource "openstack_networking_network_v2" "public-net2" {
#   name           = "public-net"
#   admin_state_up = "true"
#   external       = "true"
#   transparent_vlan = "vlan"
#
# }
# resource "openstack_networking_network_v2" "network_1" {
#   name           = "tf_test_network"
#   admin_state_up = "true"
# }
#
# resource "openstack_networking_subnet_v2" "subnet_1" {
#   network_id = "${openstack_networking_network_v2.network_1.id}"
#   cidr       = "192.168.199.0/24"
#   name       = "tf_test_subnet"
# }
resource "openstack_blockstorage_volume_v2" "volume_1" {
  name        = "volume_1"
  description = "first test volume"
  size        = 35
}
