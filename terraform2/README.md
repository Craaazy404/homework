# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.12.0

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
<img width="1836" height="128" alt="ycscr" src="https://github.com/user-attachments/assets/4bb615dd-6e92-4e2d-b0d0-d72956176cf5" />
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- <img width="504" height="132" alt="ip" src="https://github.com/user-attachments/assets/50a1b924-f0c9-4236-a89b-ed43a2601343" />
- ответы на вопросы.
  preemptible = true — ВМ может быть остановлена в любой момент, используется для экономии, подходит для неответственных задач, core_fraction=5 — гарантированная доля vCPU (5%), позволяет экономить при низкой нагрузке.



### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.
<img width="1808" height="184" alt="2026-06-23_10-34-43" src="https://github.com/user-attachments/assets/4a434c4f-17c5-4f54-b7e6-eb2eb344d31c" />
<img width="520" height="256" alt="2026-06-23_10-34-59" src="https://github.com/user-attachments/assets/9c8975e3-7d4c-4a01-947d-01388e58f147" />


### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.
<img width="1228" height="264" alt="2026-06-23_10-44-26" src="https://github.com/user-attachments/assets/f4ad5c43-f42e-467d-8d10-fb136f783bb5" />
ДОБАВЛЯЮ КОД ДЛЯ СДАЧИ ЗАДАНИЯ.
**providers.tf**
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = var.service_account_key_file
}

**variables.tf**
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

##ssh vars

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
      disk_size     = 5   # оставлено 5, чтобы не пересоздавать web-ВМ
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


**vms_platform.tf**
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

**locals.tf**
locals {
  vm_names = {
    web = var.vm_web_name
    db  = var.vm_db_name
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

**main.tf**
# ===== СЕТЬ И ПОДСЕТИ =====

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "develop-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# ===== ОБРАЗ =====

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

# ===== ВЕБ-ВМ (web) =====

resource "yandex_compute_instance" "platform" {
  name        = local.vm_names.web
  platform_id = var.vm_web_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources["web"].disk_size
      type     = var.vms_resources["web"].disk_type
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.metadata
}

# ===== БАЗА ДАННЫХ (db) =====

resource "yandex_compute_instance" "db" {
  name        = local.vm_names.db
  platform_id = var.vm_db_platform_id
  zone        = "ru-central1-b"

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources["db"].disk_size
      type     = var.vms_resources["db"].disk_type
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = local.metadata
}

**outputs.tf**
output "vms_info" {
  value = {
    web = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    db = {
      instance_name = yandex_compute_instance.db.name
      external_ip   = yandex_compute_instance.db.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.db.fqdn
    }
  }
}

**terraform.tfvars**
cloud_id                 = "b******************a"
folder_id                = "b******************e"
service_account_key_file = "key.json"
vms_ssh_root_key         = "ssh-ed25519 ************************************************** user@123"
default_zone             = "ru-central1-a"
------
