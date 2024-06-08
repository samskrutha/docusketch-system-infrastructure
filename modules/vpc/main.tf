resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = element(local.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

locals {
  azs = ["eu-west-1a", "eu-west-1b"]
}
