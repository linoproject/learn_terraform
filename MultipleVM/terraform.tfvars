vsphere_env = {
    user     = "administrator@vsphere.local"
    password = "Password01!"
    server   = "vcsa-01.linoproject.lab"
}
datacenter_name     = "HomeLabWorkload"
cluster_name        = "workload"
datastore_name      = "datastore1"

vms = {
    vm1 = {
        vCPU = 1
        vMEM = 1024
        vmname = "vm1"
    }
    vm2 = {
        vCPU = 1
        vMEM = 512
        vmname = "vm2"
    }
}
