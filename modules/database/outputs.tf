output "container_name" {
  description = "Docker container name for the PostgreSQL instance"
  value = docker_container.postgres.name
}

output "connection" {
  description = "PostgreSQL connection details"
  value = {
    host = "localhost"
    port = var.db_host_port
    name = var.db_name
    user = var.db_user
    container = docker_container.postgres.name
  }
}