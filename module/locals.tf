locals {
  name   = "Synytsyn Lab05"
  region = "eu-west-2"

  instance_type = "t2.micro"

  user_data = <<-EOT
    swap:
        filename: /swapfile
        size: 2G
        maxsize: 4G
    mounts:
        - ["swap"]
  EOT

  tags = {
    Name      = "${local.name}"
    ManagedBy = "terraform"
  }
}
