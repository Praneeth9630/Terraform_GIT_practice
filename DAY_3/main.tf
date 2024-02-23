#create VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags  = {
    name = "dev_vpc"
  }
}
#create IG and attach it to VPC
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
}
#create subnet
resource "aws_subnet" "dev" {
  vpc_id = aws_vpc.dev.id
  cidr_block = "10.0.0.0/24"


}
#create route table and in edit route add IG
resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.dev.id
  }
}
#adding subnet to route table association
resource "aws_route_table_association" "dev" {
  route_table_id = aws_route_table.dev.id
  subnet_id = aws_subnet.dev.id

}


#create SG and configure inbound and outbound rules
resource "aws_security_group" "dev" {
  vpc_id = aws_vpc.dev.id
  ingress  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


