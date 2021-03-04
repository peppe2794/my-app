variable "ip_list"{
  type = list
  default = ["192.168.6.188","192.168.6.189"]
  }
terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.6.6"
    }
  }
}
provider "proxmox" {
    pm_api_url = "https://10.224.16.41:8006/api2/json"
    pm_tls_insecure = "true"
    pm_log_enable = "true"
    pm_log_levels = {
     _default = "debug"
     _capturelog = ""
    }
}
resource "proxmox_vm_qemu" "proxmox_vm" {
  count             = 2
  name              = "node${count.index}"
  target_node       = "pve"
  clone             = "Tesi.Zagaria.KubMaster"
  memory = 8192
  cores = "6"
  pool = "Tesi_Zagaria"
  define_connection_info = false
  
ipconfig0 = "ip=${var.ip_list[count.index]}/24,gw=192.168.6.1"
disk {
  size         = "32732M"
  type         = "scsi"
  storage      = "nas_storage"
}
 }
