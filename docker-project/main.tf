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

resource "docker_image" "nginx" {
   name = "nginx:latest"
   keep_locally = true
}

resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "nginx_terraform"
  ports {
    internal = 80
    external = 8080
  }
}
