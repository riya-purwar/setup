data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "cassandra_nodes" {
  for_each                    = local.cassandra_nodes
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value.instance_type
  private_ip                  = each.value.private_ip
  vpc_security_group_ids      = each.value.security_group_ids
  subnet_id                   = each.value.subnet_id

  user_data = templatefile("../cassandra-setup.sh", {
    seeds       = local.seeds
    name        = each.value.name
    instance_ip = each.value.private_ip
    dc          = each.value.dc
    rack        = each.value.rack
  })
  tags = {
    Name = each.value.name  
  }
}