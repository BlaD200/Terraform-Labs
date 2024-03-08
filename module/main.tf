module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = local.name

  ami                         = data.aws_ami.ubuntu.id
  ignore_ami_changes          = true
  instance_type               = local.instance_type
  monitoring                  = true
  availability_zone           = data.aws_subnet.selected.availability_zone
  subnet_id                   = data.aws_subnet.selected.id
  vpc_security_group_ids      = [module.security-group.security_group_id]
  associate_public_ip_address = true
  key_name                    = module.key-pair.key_pair_name

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = false

  tags = merge({ Environment = "dev" }, local.tags)
}

module "key-pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = local.name
  create_private_key = true
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.1"

  name   = local.name
  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = merge({ Environment = "dev" }, local.tags)
}
