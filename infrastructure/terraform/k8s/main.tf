resource "yandex_kubernetes_cluster" "k8s-momo" {
    network_id = yandex_vpc_network.k8s-network.id
    master {
      version = var.k8s_version
      zonal {
        zone      = yandex_vpc_subnet.k8s-subnet.zone
        subnet_id = yandex_vpc_subnet.k8s-subnet.id
      }
      public_ip = true
    }


    service_account_id      = yandex_iam_service_account.kubernetes.id
    node_service_account_id = yandex_iam_service_account.kubernetes.id
      depends_on = [
        yandex_resourcemanager_folder_iam_binding.editor,
        yandex_resourcemanager_folder_iam_binding.images-puller
      ]
    }

    resource "yandex_vpc_network" "k8s-network" { name = "k8s-network" }

    resource "yandex_vpc_subnet" "k8s-subnet" {
       name           = "k8s-subnet"
       v4_cidr_blocks = [var.v4_cidr_blocks]
       zone           = var.zone
       network_id     = yandex_vpc_network.k8s-network.id
    }

    resource "yandex_iam_service_account" "kubernetes" {
      name        = "kubernetes"
      description = "k8s service account"
    }

    resource "yandex_resourcemanager_folder_iam_binding" "editor" {
      folder_id = var.folder_id
      role      = "editor"
      members   = ["serviceAccount:${yandex_iam_service_account.kubernetes.id}"]
    }  

    resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
      folder_id = var.folder_id
      role      = "container-registry.images.puller"
      members   = ["serviceAccount:${yandex_iam_service_account.kubernetes.id}"]
    }

    resource "yandex_kubernetes_node_group" "k8s-momo-nodes" {
      cluster_id = "${yandex_kubernetes_cluster.k8s-momo.id}"
      name       = "k8s-momo-nodes"
      version    = var.k8s_version
  
      instance_template {
        name        = "worker-{instance.short_id}"
        platform_id = var.platform_id
  
        network_interface {
          nat                = true
          subnet_ids         = ["${yandex_vpc_subnet.k8s-subnet.id}"]
        }

        resources {
          memory = var.node_memory
          cores  = var.node_cores
        }

        boot_disk {
          type = var.boot_disk_type
          size = var.boot_disk_size
        }
      } 

      scale_policy {
        auto_scale {
          min     = 1
          max     = 3
          initial = 1
        }
      }     

      allocation_policy {
        location {
          zone = var.zone
        }
      }

    } 