variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "db_image" {
  type = string
}

variable "db_name" {
  type = string
  default = "ecommerce"
}

variable "db_user" {
  type = string
  default = "postgres"
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "db_port" {
  type = number
  default = 5432
}

variable "db_host_port" {
  type = number
}