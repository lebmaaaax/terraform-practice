terraform {
  required_providers {
    docker = {
      source  = "terraform-provider-docker/docker"
      version = "~> 2.7.2"
    }
  }
}

provider "docker" {
   host = "unix:///var/run/docker.sock"
}

resource "docker_network" "app_network" {
   name = "app_network"
}

resource "docker_volume" "app_network" {
   name = "app_network"
}

resource "docker_image" "nginx" {
   name = var.nginx_image
   keep_locally = true
}

resource "docker_container" "nginx" {
   image = var.nginx_image
   name  = "nginx_server"
   network_mode = docker_network.app_network.name

   ports {
     internal = 80
     external = var.nginx_port
   }
}

resource "docker_volume" "pg_data" {
   name = "pg_data"
}

resource "docker_container" "postgres" {
   image = var.postgres_image
   name = "postgres_db"

   env = [
      "POSTGRES_USER=${var.postgres_user}",
      "POSTGRES_PASSWORD=${var.postgres_password}",
      "POSGRESS_DB=${var.postgres_db}"
   ]

  network_mode = docker_network.app_network.name

  volumes {
    volume_name = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data" 
  }
  
  ports {
     internal = 5432
     external = var.postgres_port
  }
}
 
