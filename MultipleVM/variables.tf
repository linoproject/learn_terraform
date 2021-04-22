variable "vsphere_env" {
    type = object({
        server = string
        user = string
        password = string
    })
    default = {
        server = "vcsa.local.lab"
        user = "admin@vsphere.local"
        password = "VMware1!"
    }
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

variable "vms" {
    type = map(object({
        vCPU = number
        vMEM = number
        vmname = string
    }))
}