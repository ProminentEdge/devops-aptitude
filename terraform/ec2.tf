data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "interview" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.interviewer.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids      = [aws_security_group.interview.id]
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 50
    volume_type           = "gp2"
  }

  depends_on = [ aws_security_group.interview ]

  tags = {
    Name = "interview-instance"
  }
}

output "public_ip" {
  value = aws_instance.interview.public_ip
}
