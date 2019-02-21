
provider "openstack" {
  user_name = "${var.openstack_user_name}"
  tenant_name = "${var.openstack_tenant_name}"
  password  = "${var.openstack_password}"
  auth_url  = "${var.openstack_auth_url}"
  domain_name = "Default"
}


resource "openstack_images_image_v2" "GlanceImages" {
  count = "${length(keys(var.images))}"
  name   = "${element(keys(var.images), count.index)}"
  image_source_url = "${element(values(var.images), count.index)}"
  container_format = "bare"
  disk_format = "qcow2"
  # env = ["DATA=${element(values(var.images), count.index)}"]
  properties = {
    key = "value"
  }
}
