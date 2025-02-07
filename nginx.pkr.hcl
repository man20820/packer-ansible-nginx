packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.8"
    }
    ansible = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "custom-ami" {
  ami_name      = "nginx"
  instance_type = "t3.micro"
  region        = "ap-southeast-3"
  source_ami    = "ami-0d22ac6a0e117cefe"
  ssh_username  = "ubuntu"
  tags = {
    Name = "nginx"
  }
}

build {
  sources = ["source.amazon-ebs.custom-ami"]

  provisioner "ansible" {
    playbook_file = "nginx.yaml"
    user          = "ubuntu"
  }

  # provisioner "file" {
  #   source = "files/default"
  #   destination = "/tmp/default"
  # }

  # provisioner "shell" {
  #   inline = [
  #     "sudo mv /tmp/default /etc/nginx/sites-available/default",
  #     "sudo chmod 644 /etc/nginx/sites-available/default",
  #     "sudo chown root:root /etc/nginx/sites-available/default"
  #   ]
  # }
}

