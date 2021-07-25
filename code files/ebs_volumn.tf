resource "aws_ebs_volume" "example" {

  #count = length(var.subnets_cidr)
  #availability_zone = element(aws_instance.webos1.*.availability_zone, count.index)
  availability_zone = aws_instance.webos1.availability_zone
  size              = 1

  tags = {
    Name = "Web Server HD by TF"
  }
}