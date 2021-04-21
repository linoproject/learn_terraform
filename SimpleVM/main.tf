provider "vsphere" {
    user           = "admin@vsphere.local"
    password       = "VMware1!"
    vsphere_server = "vcsa-01.linoproject.lab"
    # If you have a self-signed cert
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "HomeLabWorkload"
}

data "vsphere_datastore" "datastore" {
    name          = "datastore1"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
    name          = "workload"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
    name          = "dpgMgmtLab"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_from_ovf" {
    name          = "ubuntu1804template"
    datacenter_id = data.vsphere_datacenter.dc.id
}

resource vsphere_virtual_machine "vm1" {
    name = "test-vm-1"
    resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
    datastore_id     = data.vsphere_datastore.datastore.id

    num_cpus = 2
    memory   = 1024
    guest_id = "ubuntu64Guest"

    network_interface {
        network_id = data.vsphere_network.network.id
    }

    cdrom {
        client_device = true
    }
    
    disk {
        label = "disk0"
        size  = 20
    }

    clone {
        template_uuid = data.vsphere_virtual_machine.template_from_ovf.id
    }
}

output "vm_ip_addr" {
  value = vsphere_virtual_machine.vm1.guest_ip_addresses
}