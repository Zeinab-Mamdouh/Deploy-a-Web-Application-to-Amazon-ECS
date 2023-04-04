resource "aws_security_group" "cairo_sg" {
  vpc_id      = aws_vpc.cairo-vpc.id
  name        = "cairo-sg"
  description = "Sec Grp for Cairo ssh"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}