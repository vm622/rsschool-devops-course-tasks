data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical owner ID
}

resource "tls_private_key" "bastion_host_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "bastion_host_ssh_public_key" {
  depends_on = [tls_private_key.bastion_host_ssh_key]
  content    = tls_private_key.bastion_host_ssh_key.public_key_openssh
  filename   = "secrets/bastion_host_ssh_key.pub"
}

resource "local_sensitive_file" "bastion_host_ssh_private_key" {
  depends_on      = [tls_private_key.bastion_host_ssh_key]
  content         = tls_private_key.bastion_host_ssh_key.private_key_openssh
  filename        = "secrets/bastion_host_ssh_key"
  file_permission = "0600"
}

resource "aws_key_pair" "bastion_host_ssh_key_pair" {
  key_name   = "SSH key pair for bastion host instance"
  public_key = tls_private_key.bastion_host_ssh_key.public_key_openssh
}

data "cloudinit_config" "bastion_host_cloud_init_config" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/ec2_config/cloud_init_bastion_host.yaml", {
      ssh_public_key = tls_private_key.bastion_host_ssh_key.public_key_openssh
    })
  }
}

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [
    aws_security_group.public_instance_sg.id,
  ]
  associate_public_ip_address = true

  user_data = data.cloudinit_config.bastion_host_cloud_init_config.rendered
  tags = {
    Name = "Bastion Host"
  }
}

resource "tls_private_key" "private_instance_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_instance_ssh_public_key" {
  depends_on = [tls_private_key.private_instance_ssh_key]
  content    = tls_private_key.private_instance_ssh_key.public_key_openssh
  filename   = "secrets/private_instance_ssh_key.pub"
}

resource "local_sensitive_file" "private_instance_ssh_private_key" {
  depends_on      = [tls_private_key.private_instance_ssh_key]
  content         = tls_private_key.private_instance_ssh_key.private_key_openssh
  filename        = "secrets/private_instance_ssh_key"
  file_permission = "0600"
}

resource "aws_key_pair" "private_instance_ssh_key_pair" {
  key_name   = "SSH key pair for private instance"
  public_key = tls_private_key.private_instance_ssh_key.public_key_openssh
}

data "cloudinit_config" "private_instance_cloud_init_config" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/ec2_config/cloud_init_private_instance.yaml", {
      ssh_public_key = tls_private_key.private_instance_ssh_key.public_key_openssh
    })
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet[0].id
  vpc_security_group_ids = [
    aws_security_group.private_instance_sg.id,
  ]

  user_data = data.cloudinit_config.private_instance_cloud_init_config.rendered
  tags = {
    Name = "Private instance"
  }
}
