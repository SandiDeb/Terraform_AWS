resource "aws_instance" "Terraform_Instance" {
  instance_type          = "t2.micro"
  ami                    = "${lookup(var.aws_amis, var.aws_region)}"
  key_name               = "${aws_key_pair.deep.name}"
  vpc_security_group_ids = ["${aws_security_group.terraform_scgroup.id}"]
  subnet_id              = "${aws_subnet.terraform_subnet.id}"
  user_data              = "${file("Scripts.sh")}"
}
