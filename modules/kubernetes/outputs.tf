output "namespace" {
  description = "Kubernetes namespace created for this environment"
  value = kubernetes_namespace.env.metadata[0].name
}

output "deployments" {
  description = "All deployment names in this namespace"
  value = [
    kubernetes_deployment.product_service.metadata[0].name,
    kubernetes_deployment.order_service.metadata[0].name,
    kubernetes_deployment.frontend.metadata[0].name,
  ]
}

output "services" {
  description = "Service name to NodePort mapping"
  value = {
    product_service = kubernetes_service.product_service.spec[0].port[0].node_port
    order_service = kubernetes_service.order_service.spec[0].port[0].node_port
    frontend = kubernetes_service.frontend.spec[0].port[0].node_port
  }
}