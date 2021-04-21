data "vsphere_datacenter" "dc" {
  name = var.datacenter_name
}

data "vsphere_datastore" "datastore" {
    name          = var.datastore_name
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
    name          = var.cluster_name
    datacenter_id = data.vsphere_datacenter.dc.id
}

