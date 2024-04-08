packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = ">= 1.0.0"
    }
  }
}

variable "credentials" {}
variable "project_id" {}
variable "MYSQL_PASSWORD" {}
variable "MYSQL_DATABASENAME" {}
variable "MYSQL_USERNAME" {}
variable "MYSQL_HOSTNAME" {}
variable "SALT_ROUNDS" {}
variable "PORT" {}

source "googlecompute" "autogenerated_1" {
  credentials_file  = var.credentials
  image_description = "A custom centos8 image with MySQL installed"
  image_labels = {
    os = "centos8"
  }
  image_name   = "csye-centos-8-1"
  network      = "default"
  project_id   = var.project_id
  source_image = "centos-stream-8-v20240312"
  ssh_username = "packer"
  zone         = "us-east1-c"
}

build {
  sources = ["source.googlecompute.autogenerated_1"]

  provisioner "shell" {
    inline = [
      "sudo setenforce 0"
    ]
  }


  provisioner "file" {
    source      = "/home/runner/work/webapp/webapp/webapp.zip"
    destination = "/tmp/webapp.zip"
  }

  provisioner "shell" {
    scripts = [
      "./nodejs.sh",
      "./permissions.sh",
      "./webapp-installation.sh",
      "./webapp-service.sh",
      "./user-permission.sh",
      "./ops-agent.sh"
    ]
    environment_vars = [
      "MYSQL_PASSWORD=${var.MYSQL_PASSWORD}",
      "MYSQL_DATABASENAME=${var.MYSQL_DATABASENAME}",
      "MYSQL_USERNAME=${var.MYSQL_USERNAME}",
      "MYSQL_HOSTNAME=${var.MYSQL_HOSTNAME}",
      "SALT_ROUNDS=${var.SALT_ROUNDS}",
      "PORT=${var.PORT}",
    ]
  }

}
