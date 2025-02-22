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

module "network" {
  source = "./modules/network"
}

module "database" {
  source          = "./modules/database"
  postgres_image  = var.postgres_image
  postgres_port   = var.postgres_port
  postgres_user   = var.postgres_user
  postgres_password = var.postgres_password
  postgres_db     = var.postgres_db
}

module "web" {
  source      = "./modules/web"
  nginx_image = var.nginx_image
  nginx_port  = var.nginx_port
} 
