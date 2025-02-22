terraform {
   required_providers {
     docker = {
        source = "terraform-provider-docker/docker"
        version = "~> 2.7.2"
     }
   }
}
   
resource "docker_volume" "pg_data" {
  name = "pg_data"
}

resource "docker_container" "postgres" {
  image = var.postgres_image
  name  = "postgres_db"

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]

  network_mode = "app_network"

  volumes {
    volume_name    = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data"
  }

  ports {
    internal = 5432
    external = var.postgres_port
  }
}
