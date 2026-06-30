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
    subnet_id = yandex_vpc_subnet.develop-b.id   # <-- ПРАВИЛЬНАЯ ПОДСЕТЬ
    nat       = true
  }

  metadata = local.metadata
}
