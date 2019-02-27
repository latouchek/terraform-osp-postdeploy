
# variable "count" {
#   default = 3
# }
resource "openstack_compute_instance_v2" "TestVM" {
  name = "${element(var.name, count.index)}"
  image_name = "${element(var.image, count.index)}"
  flavor_name = "${element(var.flavor, count.index)}"
  key_pair = "${var.ssh_key_pair}"
  security_groups = ["${var.security_group}"]
  network {
    name = "${var.network}"
    fixed_ip_v4 = "${element(var.ip, count.index)}"
  }
  #user_data = "${file("user-data")}"
  user_data      = <<-EOF
                   #cloud-config
                   hostname: ${element(var.name, count.index)}
                   fqdn: ${element(var.name, count.index)}.lab.local
                   manage_etc_hosts: true
                   debug: true
                   output: { all: "| tee -a /var/log/cloud-init-output.log" }
                   package_upgrade: true
                   users:
                    - default
                    - name: stack
                      sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                      groups: wheel,adm
                      ssh_pwauth: True
                      ssh_authorized_keys:
                        - ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACn2xfgfgNCabNbQZqKqw2R0JB+PYYwc0L8aXgiO0toJgaTNSsKTtCHlsgJsxBb+C7SCOew9Yf1zH2Hs3+gnxWkkgB0MtGvovNgbATbyWfLANxL4HWugHR54gqJ5m2Kd78oTjErG8bPVero/u9d60Y2kZFK0Pmdu+4ZoFiTZNMjg+RvDQ== latouche@metal-robot-music
                    - name: root
                      ssh_authorized_keys:
                        - ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACn2xfgfgNCabNbQZqKqw2R0JB+PYYwc0L8aXgiO0toJgaTNSsKTtCHlsgJsxBb+C7SCOew9Yf1zH2Hs3+gnxWkkgB0MtGvovNgbATbyWfLANxL4HWugHR54gqJ5m2Kd78oTjErG8bPVero/u9d60Y2kZFK0Pmdu+4ZoFiTZNMjg+RvDQ== latouche@metal-robot-music
                   ssh_pwauth: True
                   disable_root: false
                   chpasswd:
                     list: |
                      root:toor
                      stack:stack
                     expire: false
                   growpart:
                     mode: auto
                     devices: ['/']
                   packages:
                     - wget
                     - git
                     - tmux
                     - net-tools
                   EOF
}
