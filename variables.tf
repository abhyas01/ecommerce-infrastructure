variable "project_name" {
  description = "Base name for all resources"
  type = string
  default = "ecommerce"
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type = string
  default = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubernetes context to use (minikube)"
  type = string
  default = "minikube"
}

variable "namespace" {
  description = "Kubernetes namespace for this environment"
  type = string
}

variable "replicas" {
  description = "Number of pod replicas per deployment"
  type = number
  default = 1
}

variable "image_pull_policy" {
  description = "Image pull policy for Kubernetes deployments"
  type = string
  default = "IfNotPresent"
}

variable "docker_host" {
  description = "Docker daemon socket"
  type = string
  default = "unix:///var/run/docker.sock"
}

variable "product_image" {
  description = "Full image reference for product-service"
  type = string
}

variable "order_image" {
  description = "Full image reference for order-service"
  type = string
}

variable "frontend_image" {
  description = "Full image reference for ecommerce-frontend"
  type = string
}

variable "db_image" {
  description = "Full image reference for ecommerce-database"
  type = string
  default = "01abhyas/ecommerce-database:latest"
}

variable "registry_server" {
  description = "Container registry server"
  type = string
  default = "https://index.docker.io/v1/"
}

variable "registry_username" {
  description = "Docker Hub username"
  type = string
  default = "01abhyas"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type = string
  default = "ecommerce"
}

variable "db_user" {
  description = "PostgreSQL username"
  type = string
  default = "postgres"
}

variable "db_password" {
  description = "PostgreSQL password"
  type = string
  default = "password"
  sensitive = true
}

variable "db_port" {
  description = "PostgreSQL port inside container"
  type = number
  default = 5432
}

variable "db_host_port" {
  description = "PostgreSQL port exposed on host"
  type = number
}

variable "product_svc_port" {
  description = "product-service NodePort"
  type = number
}

variable "order_svc_port" {
  description = "order-service NodePort"
  type = number
}

variable "frontend_port" {
  description = "ecommerce-frontend NodePort"
  type = number
}