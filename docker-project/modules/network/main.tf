terraform {
    required_providers {
       docker = {
         source = "terraform-provider-docker/docker"
         version = "~> 2.7.2"
       }
    }
}

data "docker_network" "app_network" {
  name = "app_network"
}
