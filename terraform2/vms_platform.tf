## VM web variables

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name for web"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Platform ID for web VM"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for web VM"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory in GB for web VM"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "Core fraction for web VM"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for web VM"
}

variable "vm_web_disk_size" {
  type        = number
  default     = 10
  description = "Disk size in GB for web VM"
}

variable "vm_web_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Disk type for web VM"
}

## VM db variables

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM name for db"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Platform ID for db VM"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for db VM"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Memory in GB for db VM"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "Core fraction for db VM"
}

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for db VM"
}

variable "vm_db_disk_size" {
  type        = number
  default     = 10
  description = "Disk size in GB for db VM"
}

variable "vm_db_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Disk type for db VM"
}
