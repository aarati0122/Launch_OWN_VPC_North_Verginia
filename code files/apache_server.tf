resource "null_resource"  "nullremote1" {


depends_on = [
  aws_volume_attachment.ebs_att
]


connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/AS/Desktop/Terraform LW/terraform-key.pem")
    host     = aws_instance.webos1.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum  install httpd  -y",
      "sudo  yum  install php  -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

      "sudo mkfs.ext4 /dev/xvdc",
      
      "sudo yum install git -y",
      "sudo git clone https://github.com/aarati0122/sample-webpage.git  /var/www/html/",
      "sudo git clone https://github.com/aarati0122/sample-webpage.git   /var/www/cgi-bin/",
	  
	  #"sudo rm -rf /var/www/cgi-bin/index.html",
	  #"sudo rm -rf /var/www/html/cmd.py",
	  #"sudo  mount /dev/xvdc  /var/www/html",
	  "sudo chmod 777 /var/www/cgi-bin/cmd.py"

	
    ]
  }


provisioner "local-exec" {
   command = "start chrome http://aws_instance.webos1.public_ip/index.html"
  }

}

