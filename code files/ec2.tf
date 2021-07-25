resource "aws_instance" "webos1"{
  #vpc_id      = aws_vpc.main.id
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
  #security_groups =  ["launch-wizard-1"]
  #subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  #security_groups   = ["${aws_security_group.mysg.name}"]
  key_name = "terraform-key"
  subnet_id = aws_subnet.main.id
  #key_name = "${aws_key_pair.keypair.key_name}"
  #count = length(var.subnets_cidr)
  #subnet_id      = element(aws_subnet.main.*.id, count.index)
  

  tags = {
    Name = "Web Server by TF"
  }

}