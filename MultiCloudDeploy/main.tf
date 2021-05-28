module "ModuleVM" {
    source = "../SimpleVM"
}
module "SimpleEC2" {
    source = "../SimpleEC2"
}

output "vm_ip_addr" {
  value       = module.ModuleVM.vm_ip_addr
  description = "The private IP address of the VM"
}
output "ec2_ip_addr" {
  value       = module.SimpleEC2.public_ip
  description = "The public IP address of the EC2 Instance"
}
