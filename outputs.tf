output "environment" {
  description = "Active Terraform workspace / environment"
  value = terraform.workspace
}

output "namespace" {
  description = "Kubernetes namespace for this environment"
  value = module.kubernetes.namespace
}

output "cluster_connection" {
  description = "Minikube cluster connection details for Jenkins pipeline"
  value = {
    context = var.kube_context
    kubeconfig_path = var.kubeconfig_path
    namespace = module.kubernetes.namespace
  }
}

output "minikube_ip" {
  description = "Minikube cluster IP — run: minikube ip"
  value = "Run: minikube ip"
}

output "service_urls" {
  description = "Service URLs accessible from the host via minikube NodePort"
  value = {
    product_service = "http://$(minikube ip):${var.product_svc_port}"
    order_service = "http://$(minikube ip):${var.order_svc_port}"
    frontend = "http://$(minikube ip):${var.frontend_port}"
  }
}

output "product_service_port" {
  description = "product-service NodePort"
  value = var.product_svc_port
}

output "order_service_port" {
  description = "order-service NodePort"
  value = var.order_svc_port
}

output "frontend_port" {
  description = "ecommerce-frontend NodePort"
  value = var.frontend_port
}

output "database_connection" {
  description = "PostgreSQL connection details for Jenkins integration tests"
  value = {
    host = "localhost"
    port = var.db_host_port
    name = var.db_name
    user = var.db_user
  }
  sensitive = false
}

output "database_container_name" {
  description = "Docker container name for the PostgreSQL instance"
  value = module.database.container_name
}

output "registry_info" {
  description = "Docker registry details for Jenkins pipeline image push"
  value = module.registry.registry_info
}

output "image_references" {
  description = "Full image references per service for kubectl deployments"
  value = module.registry.image_references
}

output "jenkins_pipeline_vars" {
  description = "All values Jenkins pipelines need — retrieve with: terraform output -json jenkins_pipeline_vars"
  value = {
    kube_context = var.kube_context
    kube_namespace = module.kubernetes.namespace
    registry_server = var.registry_server
    registry_user = var.registry_username
    product_image = var.product_image
    order_image = var.order_image
    frontend_image = var.frontend_image
    db_host = "localhost"
    db_port = tostring(var.db_host_port)
    db_name = var.db_name
    db_user = var.db_user
    product_svc_port = tostring(var.product_svc_port)
    order_svc_port = tostring(var.order_svc_port)
    frontend_port = tostring(var.frontend_port)
  }
}