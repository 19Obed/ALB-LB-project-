#creating application load balancer 

#creating configuration      

#creating ami
data "aws_ami" "Amazon_Linux" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.1.20230705.0-kernel-6.1-x86_64"]
  }
}

#creating autoscaling  launch configuration 

resource "aws_launch_configuration" "Lezuha_EC2_LC" {
  name            = "Lezuha-EC2-LC"
  image_id        = data.aws_ami.Amazon_Linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.Lezuha_asg_sec_group.id]
}

#creating aws autoscaling group

resource "aws_autoscaling_group" "Lezuha_ASG" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.Lezuha_EC2_LC.id
  vpc_zone_identifier  = [aws_subnet.Lezuha-pub-subnet1.id, aws_subnet.Lezuha-pub-subnet2.id]
}

#creating application load balancer

resource "aws_lb" "Lezuha_lb" {
  name               = "Lezuha-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Lezuha_lb_sec_group.id]
  subnets            = [aws_subnet.Lezuha-pub-subnet1.id, aws_subnet.Lezuha-pub-subnet2.id]
}

#creating ELB listener

resource "aws_lb_listener" "Lezuha_listener" {
  load_balancer_arn = aws_lb.Lezuha_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Lezuha_TG.arn
  }
}

#creating LB target group

resource "aws_lb_target_group" "Lezuha_TG" {
  name     = "Lezuha-TG"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Lezuha-VPC.id
}

#creating alb target group
resource "aws_lb_target_group" "Lezuha-alb-TG" {
  name        = "Lezuha-alb-TG"
  target_type = "instance"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.Lezuha-VPC.id
}

resource "aws_autoscaling_attachment" "Lezuha_autoscaling_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.Lezuha_ASG.id
  alb_target_group_arn   = aws_lb_target_group.Lezuha-alb-TG.arn
  
}

