resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdc"
  #volume_id   = aws_ebs_volume.example.id
  #instance_id = aws_instance.webos1.id  
  #subnet_id      = element(aws_subnet.main.*.id, count.index)
  
  
  volume_id = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.webos1.id}"
  
  #count = length(var.subnets_cidr)
  #instance_id  = "${element(aws_instance.webos1.*.id, count.index)}"
  #volume_id    = "${element(aws_ebs_volume.example.*.id, count.index)}"
  
  force_detach = true
}
