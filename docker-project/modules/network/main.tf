terraform {
    required_providers {
       docker = {
         source = "terraform-provider-docker/docker"
         version = "~> 2.7.2"
       }
    }
}

resource "docker_network" "app_network" {
  name = "app_network"
}
