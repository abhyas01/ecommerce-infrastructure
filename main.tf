terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.4"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
  config_context = var.kube_context
}

provider "docker" {
  host = var.docker_host
}

provider "local" {}

locals {
  workspace = terraform.workspace
  env_label = local.workspace
  name_prefix = "${var.project_name}-${local.workspace}"
}

module "kubernetes" {
  source = "./modules/kubernetes"

  environment = local.env_label
  project_name = var.project_name
  namespace = var.namespace
  db_port = var.db_port
  product_svc_port = var.product_svc_port
  order_svc_port = var.order_svc_port
  frontend_port = var.frontend_port
  replicas = var.replicas
  image_pull_policy = var.image_pull_policy

  product_image = var.product_image
  order_image = var.order_image
  frontend_image = var.frontend_image
  db_image = var.db_image
}

module "database" {
  source = "./modules/database"

  environment = local.env_label
  project_name = var.project_name
  db_image = var.db_image
  db_name = var.db_name
  db_user = var.db_user
  db_password = var.db_password
  db_port = var.db_port
  db_host_port = var.db_host_port
}

module "registry" {
  source = "./modules/registry"

  environment = local.env_label
  project_name = var.project_name
  registry_username = var.registry_username
  registry_server = var.registry_server
  namespace = var.namespace
  product_image = var.product_image
  order_image = var.order_image
  frontend_image = var.frontend_image
  db_image = var.db_image
}