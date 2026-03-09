resource "kubernetes_namespace" "env" {
  metadata {
    name = var.namespace
    labels = {
      environment = var.environment
      project = var.project_name
      managed-by = "terraform"
    }
  }
}

resource "kubernetes_deployment" "product_service" {
  metadata {
    name = "product-service"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = {
      app = "product-service"
      environment = var.environment
      managed-by = "terraform"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = { app = "product-service" }
    }

    template {
      metadata {
        labels = { app = "product-service", environment = var.environment }
      }

      spec {
        container {
          name = "product-service"
          image = var.product_image
          image_pull_policy = var.image_pull_policy

          port { container_port = 3001 }

          env {
            name = "DB_HOST"
            value = "localhost"
          }
          env {
            name = "DB_PORT"
            value = tostring(var.db_port)
          }
          env {
            name = "DB_NAME"
            value = "ecommerce"
          }
          env {
            name = "DB_USER"
            value = "postgres"
          }
          env {
            name = "DB_PASSWORD"
            value = "password"
          }
          env {
            name = "PORT"
            value = "3001"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "product_service" {
  metadata {
    name = "product-service"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = { app = "product-service", environment = var.environment }
  }

  spec {
    selector = { app = "product-service" }
    type = "NodePort"

    port {
      port = 3001
      target_port = 3001
      node_port = var.product_svc_port
    }
  }
}

resource "kubernetes_deployment" "order_service" {
  metadata {
    name = "order-service"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = {
      app = "order-service"
      environment = var.environment
      managed-by = "terraform"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = { app = "order-service" }
    }

    template {
      metadata {
        labels = { app = "order-service", environment = var.environment }
      }

      spec {
        container {
          name = "order-service"
          image = var.order_image
          image_pull_policy = var.image_pull_policy

          port { container_port = 3002 }

          env {
            name = "DB_HOST"
            value = "localhost"
          }
          env {
            name = "DB_PORT"
            value = tostring(var.db_port)
          }
          env {
            name = "DB_NAME"
            value = "ecommerce"
          }
          env {
            name = "DB_USER"
            value = "postgres"
          }
          env {
            name = "DB_PASSWORD"
            value = "password"
          }
          env {
            name = "PRODUCT_SERVICE_URL"
            value = "http://product-service:3001"
          }
          env {
            name = "PORT"
            value = "3002"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "order_service" {
  metadata {
    name = "order-service"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = { app = "order-service", environment = var.environment }
  }

  spec {
    selector = { app = "order-service" }
    type = "NodePort"

    port {
      port = 3002
      target_port = 3002
      node_port = var.order_svc_port
    }
  }
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "ecommerce-frontend"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = {
      app = "ecommerce-frontend"
      environment = var.environment
      managed-by = "terraform"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = { app = "ecommerce-frontend" }
    }

    template {
      metadata {
        labels = { app = "ecommerce-frontend", environment = var.environment }
      }

      spec {
        container {
          name = "ecommerce-frontend"
          image = var.frontend_image
          image_pull_policy = var.image_pull_policy

          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "ecommerce-frontend"
    namespace = kubernetes_namespace.env.metadata[0].name
    labels = { app = "ecommerce-frontend", environment = var.environment }
  }

  spec {
    selector = { app = "ecommerce-frontend" }
    type = "NodePort"

    port {
      port = 80
      target_port = 80
      node_port = var.frontend_port
    }
  }
}