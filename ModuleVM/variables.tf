variable vsphere_server {
  type = string
  default = "vcsa-01.linoproject.lab"
}

variable vsphere_user {
  type = string
  default = "admin@vsphere.local"
}

variable vsphere_password {
  type = string
  default = "VMware1!"
}

variable datacenter_name {
  type        = string
  description = "The name of the vSphere Datacenter into which resources will be created."
  default = "HomeLabWorkload"
}

variable cluster_name {
  type        = string
  description = "The vSphere Cluster into which resources will be created."
  default = "workload"
}

variable datastore_name {
  type        = string
  description = "The vSphere Datastore into which resources will be created."
  default = "datastore1"
}