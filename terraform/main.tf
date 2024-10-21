# creating ec2 instance

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]  # Change to the Ubuntu version you need
  }
   # Canonical's AWS Account ID
}

# EC2 Instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type_instance
  user_data     = file("script_toinstall.sh")
  tags = {
    Name = "UbuntuServer"
  }
}


