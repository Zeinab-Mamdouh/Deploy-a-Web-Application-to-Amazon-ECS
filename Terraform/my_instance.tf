resource "aws_key_pair" "cairo-key" {
  key_name   = "cairo-key"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "app_server" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.cairo-pub-1.id
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.cairo-key.key_name
  vpc_security_group_ids = [aws_security_group.cairo_sg.id]
  tags = {
    Name    = "web-server"
    Project = "ecs-project"
  }
}

resource "aws_ebs_volume" "vol_4_cairo" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "extra-vol-4-cairo"
  }
}

resource "aws_volume_attachment" "attach_vol_cairo" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_4_cairo.id
  instance_id = aws_instance.app_server.id
}

output "PublicIP" {
  value = aws_instance.app_server.public_ip
}

output "PrivateIP" {
  value = aws_instance.app_server.private_ip
}