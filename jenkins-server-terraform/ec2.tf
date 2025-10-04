resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type 
  # The key pair name for SSH access to the instance
  key_name               = var.key_name
  subnet_id              = aws_subnet.public-subnet.id
  
  # Security group IDs to control inbound and outbound traffic
  vpc_security_group_ids = [aws_security_group.security-group.id]
  
  # IAM instance profile to attach policies to the EC2 instance
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  
  root_block_device {
    volume_size = 30
  }
  
  # User data script executed on instance launch
  user_data = templatefile("./scripts/tools-install.sh", {})

  tags = {
    Name        = var.instance_name
  }
}

# Outputs to access instance details after creation
output "instance_id" {
  value = aws_instance.ec2.id
}

output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}
