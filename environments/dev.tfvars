project_name = "ecommerce"
namespace = "dev"
replicas = 1
image_pull_policy = "Always"

kubeconfig_path = "~/.kube/config"
kube_context = "minikube"

product_image = "01abhyas/product-service:latest"
order_image = "01abhyas/order-service:latest"
frontend_image = "01abhyas/ecommerce-frontend:latest"
db_image = "01abhyas/ecommerce-database:latest"

registry_server = "https://index.docker.io/v1/"
registry_username = "01abhyas"

db_name = "ecommerce"
db_user = "postgres"
db_password = "password"
db_port = 5432
db_host_port = 5433

product_svc_port = 30001
order_svc_port = 30002
frontend_port = 30000
