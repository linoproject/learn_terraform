#### May change based on VM
data "vsphere_network" "network" {
    name          = "dpgMgmtLab"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_from_ovf" {
    name          = "ubuntu-focal-20.04-cloudimg"
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
        unit_number = 0
    }
    disk {
        label = "diskextra"
        attach = true
        path = vsphere_virtual_disk.disk_extra.vmdk_path
        unit_number = 1
        datastore_id = data.vsphere_datastore.datastore.id
    }
   
    clone {
        template_uuid = data.vsphere_virtual_machine.template_from_ovf.id
    }
}

resource "vsphere_virtual_disk" "disk_extra" {
  size       = 2
  vmdk_path  = "extra.vmdk"
  datastore = data.vsphere_datastore.datastore.name
  datacenter = data.vsphere_datacenter.dc.name
  
  type       = "thin"
}

