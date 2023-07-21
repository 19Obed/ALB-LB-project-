#EC2 instances for Lezuha

# EC2 instances in public subnet1

resource "aws_instance" "Lezuha-pub-server-1" {
  ami                         = "ami-038056f5d3df2259d"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Lezuha-sec.id]
  subnet_id                   = aws_subnet.Lezuha-pub-subnet1.id
  user_data = file("script.sh")

  tags = {
    Name = "Lezuha-pub-server-1"
  }
}

resource "aws_instance" "Lezuha-pub-server-2" {
  ami                         = "ami-038056f5d3df2259d"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Lezuha-sec.id]
  subnet_id                   = aws_subnet.Lezuha-pub-subnet1.id
  user_data                   = file("script2.sh")


  tags = {
    Name = "Lezuha-pub-server-2"
  }
}

#EC2 instances in public subnet2

resource "aws_instance" "Lezuha-pub-server-3" {
  ami                         = "ami-038056f5d3df2259d"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Lezuha-sec.id]
  subnet_id                   = aws_subnet.Lezuha-pub-subnet2.id
  user_data                   = file("script.sh")


  tags = {
    Name = "Lezuha-pub-server-3"
  }
}

resource "aws_instance" "Lezuha-pub-server-4" {
  ami                         = "ami-038056f5d3df2259d"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Lezuha-sec.id]
  subnet_id                   = aws_subnet.Lezuha-pub-subnet2.id
  user_data                   = file("script2.sh")
  tags = {
    Name = "Lezuha-pub-server-4"
  }
}