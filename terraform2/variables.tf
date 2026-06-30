##cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to the service account key file in JSON format"
}


## map variables for resources

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      disk_size     = 5   # чтобы не пересоздавать web-ВМ
      disk_type     = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_size     = 10
      disk_type     = "network-hdd"
    }
  }
}
