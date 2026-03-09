output "registry_info" {
  description = "Docker registry connection details"
  value = {
    server = var.registry_server
    username = var.registry_username
  }
}

output "image_references" {
  description = "Full image references per service"
  value = {
    product_service = var.product_image
    order_service = var.order_image
    ecommerce_frontend = var.frontend_image
    ecommerce_database = var.db_image
  }
}

output "env_file_path" {
  description = "Path to generated registry env file"
  value = local_file.registry_env.filename
}