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
   name = "nginx:latest"
   keep_locally = true
}

resource "docker_container" "nginx" {
   image = docker_image.nginx.name
   name  = "nginx_server"
   network_mode = docker_network.app_network.name

   ports {
     internal = 80
     external = 8080
   }
}

resource "docker_volume" "pg_data" {
   name = "pg_data"
}

resource "docker_container" "postgres" {
   image = "postgres:15"
   name = "postgres_db"

   env = [
      "POSTGRES_USER=admin",
      "POSTGRES_PASSWORD=admin",
      "POSGRESS_DB=mydb"
   ]

  network_mode = docker_network.app_network.name

  volumes {
    volume_name = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data" 
  }
  
  ports {
     internal = 5432
     external = 5432
  }
}
 
