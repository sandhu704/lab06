resource "aws_instance" "instance" {
  ami           = "ami-04e5276ebb8451442"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.iam_profile.name

  tags = {
    Name = "EC2Instance"
  }
}



resource "aws_security_group" "sg" {
  name        = "sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
