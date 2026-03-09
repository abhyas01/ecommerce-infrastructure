variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "replicas" {
  type = number
  default = 1
}

variable "image_pull_policy" {
  type = string
  default = "IfNotPresent"
}

variable "db_port" {
  type = number
  default = 5432
}

variable "product_svc_port" {
  type = number
}

variable "order_svc_port" {
  type = number
}

variable "frontend_port" {
  type = number
}

variable "product_image" {
  type = string
}

variable "order_image" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "db_image" {
  type = string
}