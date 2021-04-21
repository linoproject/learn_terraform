module "ModuleVM" {
    source = "../ModuleVM"
}

output "vm_ip_addr" {
  value       = module.ModuleVM.vm_ip_addr
  description = "The private IP address of the main server instance."
}