terraform {
   required_providers {
     docker = {
        source = "terraform-provider-docker/docker"
        version = "~> 2.7.2"
     }
   }
}

resource "docker_container" "nginx" {
   image = var.nginx_image
   name = "nginx_server"
   
   network_mode = "app_network"

   ports {
     internal = 80
     external = var.nginx_port
   }
}
