resource "local_file" "registry_env" {
  filename = "${path.root}/state/registry-${var.environment}.env"
  content = <<-EOF
    REGISTRY_SERVER=${var.registry_server}
    REGISTRY_USER=${var.registry_username}
    IMAGE_PRODUCT=${var.product_image}
    IMAGE_ORDER=${var.order_image}
    IMAGE_FRONTEND=${var.frontend_image}
    IMAGE_DATABASE=${var.db_image}
    KUBE_NAMESPACE=${var.namespace}
    ENVIRONMENT=${var.environment}
  EOF

  file_permission = "0644"
}