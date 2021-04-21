output "vm_ip_addr" {
  value = vsphere_virtual_machine.vm1.guest_ip_addresses
}