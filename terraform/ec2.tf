resource "aws_instance" "aws_ec2" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.aws_ec2_subnet.id
  vpc_security_group_ids = [aws_security_group.aws_ec2_sg.id]
  key_name               = "DominikKoltai"

  tags = {
    Name = "aws-ec2"
  }
}