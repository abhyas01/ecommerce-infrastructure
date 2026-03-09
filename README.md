# ecommerce-infrastructure

## State File Backup Procedures

Terraform automatically creates a `terraform.tfstate.backup` file after every successful apply, containing the previous state.

For manual backups before major changes:

```bash
cp -r terraform.tfstate.d/ terraform.tfstate.d.backup.$(date +%Y%m%d-%H%M%S)/

cp -r terraform.tfstate.d/prod/ terraform.tfstate.d.prod.backup.$(date +%Y%m%d-%H%M%S)/
```

State files are excluded from version control via `.gitignore` as they may contain sensitive values such as database passwords. The `.tf` configuration files in GitHub are sufficient to fully recreate all infrastructure from scratch using `terraform apply`.

## Retrieving Terraform Outputs for CI/CD Pipeline Configuration

Always select the correct workspace before retrieving outputs:

```bash
terraform workspace select dev

terraform output -json jenkins_pipeline_vars

terraform output namespace
terraform output -json service_urls
terraform output -json cluster_connection
terraform output -json registry_info
```

### jenkins_pipeline_vars

The primary output for Jenkins CI/CD integration. Contains all values a Jenkins pipeline needs to connect to the correct environment:

```json
{
  "db_host":          "localhost",
  "db_name":          "ecommerce",
  "db_port":          "5433",
  "db_user":          "postgres",
  "frontend_image":   "01abhyas/ecommerce-frontend:latest",
  "frontend_port":    "30000",
  "kube_context":     "minikube",
  "kube_namespace":   "dev",
  "order_image":      "01abhyas/order-service:latest",
  "order_svc_port":   "30002",
  "product_image":    "01abhyas/product-service:latest",
  "product_svc_port": "30001",
  "registry_server":  "https://index.docker.io/v1/",
  "registry_user":    "01abhyas"
}
```

### Using outputs in a Jenkins pipeline

The registry module generates `state/registry-<env>.env` which can be sourced directly in a Jenkins pipeline stage:

```bash
source ./state/registry-dev.env
kubectl set image deployment/product-service \
  product-service=$IMAGE_PRODUCT \
  -n $KUBE_NAMESPACE
```

Or retrieve values inline using Terraform:

```bash
terraform workspace select dev
NAMESPACE=$(terraform output -raw namespace)
kubectl set image deployment/product-service product-service=01abhyas/product-service:latest -n $NAMESPACE
```
