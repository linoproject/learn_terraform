
locals{
  AllVms = [
    for vm in vsphere_virtual_machine.vms:{
      "name" = vm.name
      "ip" = vm.guest_ip_addresses
    }
  ]
}

output "name" {
  value = local.AllVms
}