provider "vsphere" {
    user           = var.vsphere_env.user
    password       = var.vsphere_env.password
    vsphere_server = var.vsphere_env.server
    # If you have a self-signed cert
    allow_unverified_ssl = true
}

#### May change based on VM
data "vsphere_network" "network" {
    name          = "dpgMgmtLab"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_from_ovf" {
    name          = "ubuntu-focal-20.04-cloudimg"
    datacenter_id = data.vsphere_datacenter.dc.id
}



resource vsphere_virtual_machine "vms" {
    for_each = var.vms
    
    name = each.value.vmname
    resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
    datastore_id     = data.vsphere_datastore.datastore.id

    num_cpus = each.value.vCPU
    memory   = each.value.vMEM
    guest_id = "ubuntu64Guest"

    network_interface {
        network_id = data.vsphere_network.network.id
    }

    cdrom {
        client_device = true
    }
    
    disk {
        label = "disk0"
        size  = 10
        unit_number = 0
    }
   
    clone {
        template_uuid = data.vsphere_virtual_machine.template_from_ovf.id
    }
}


