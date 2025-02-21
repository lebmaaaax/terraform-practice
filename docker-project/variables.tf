variable "nginx_image" {
   default = "nginx:latest"
}

variable "nginx_port" {
  default = 8080
}

variable "postgres_image" {
  default = "postgres:15"
}

variable "postgres_port" {
  default = 5432
}

variable "postgres_user" {
  default = "admin"
}

variable "postgres_password" {
  default = "admin"
}

variable "postgres_db" {
 default = "mydb"
}
