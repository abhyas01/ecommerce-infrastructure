terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# PostgreSQL container for local integration testing
# One container per environment, differentiated by host port

resource "docker_image" "postgres" {
  name = var.db_image
  keep_locally = true
}

resource "docker_container" "postgres" {
  name = "${var.project_name}-postgres-${var.environment}"
  image = docker_image.postgres.image_id

  restart = "unless-stopped"

  ports {
    internal = 5432
    external = var.db_host_port
  }

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "managed-by"
    value = "terraform"
  }

  healthcheck {
    test = ["CMD-SHELL", "pg_isready -U ${var.db_user} -d ${var.db_name}"]
    interval = "10s"
    timeout = "5s"
    retries = 5
    start_period = "10s"
  }
}