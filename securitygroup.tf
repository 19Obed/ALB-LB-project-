#EC2 security group 

resource "aws_security_group" "Lezuha-sec" {
  name        = "Lezuha-sec"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Lezuha-VPC.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Lezuha-sec"
  }
}

#creating security group for autoscaling group

resource "aws_security_group" "Lezuha_asg_sec_group" {
  name = "Lezuha-asg"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.Lezuha-sec.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.Lezuha-sec.id]
  }

  vpc_id = aws_vpc.Lezuha-VPC.id
}

resource "aws_security_group" "Lezuha_lb_sec_group" {
  name = "Lezuha-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.Lezuha-VPC.id
}