variable "cloud_id" {
  type        = string
  default     = "b1g46auuh4pqpnbsp9rc"
  description = "Yandex cloud identificator"
}

variable "folder_id" {
  type        = string
  default     = "b1gr1lfntsa2gnkj2ftf"
  description = "Yandex folder identificator"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Availability zone in which all cloud resources are created by default"
}

variable "iam_token" {
  type        = string
  description = "IAM Token"
}

variable "v4_cidr_blocks" {
  type        = string
  default     = "192.168.0.0/16"
}

variable "k8s_version" {
  type        = string
  default     = "1.26"
}

variable "platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "node_memory" {
  type        = number
  default     = 2
}

variable "node_cores" {
  type        = number
  default     = 2
}

variable "boot_disk_type" {
  type        = string
  default     = "network-hdd"
}

variable "boot_disk_size" {
  type        = number
  default     = 32
}