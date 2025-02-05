resource "aws_vpc" "main_vpc" {
    cidr_block = ""

    tags = {
      Name = "main-vpc"
    }
}

resource "aws_subnet" "main_subnet" {
    cidr_block = ""
    availability_zone = "ap-south-1a"
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      Name:"main-subnet"
    }
}

resource "aws_internet_gateway" "main_IGW" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      Name = "Main-igw"
    }
}

resource "aws_route_table" "main_route_table" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = ""
        gateway_id = aws_internet_gateway.main_IGW.id
    }

    tags = {
      Name = "Main_route"
    }
  
}

resource "aws_route_table_association" "main_association" {
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.main_route_table.id
  
}

resource "aws_security_group" "main_security_group" {
    vpc_id = aws_vpc.main_vpc.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [""]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [""]
}
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [""]
    }
}

resource "aws_instance" "webserver" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_pair
    availability_zone = "ap-south-1a"
    subnet_id = aws_subnet.main_subnet.id
    security_groups = [aws_security_group.main_security_group.id]
    associate_public_ip_address = true  

    user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        echo "<h1>Im Jash , This is my first time hosting an webserver using terraform</h1>" > /var/www/html/index.html
    EOF

    
    tags = {
      Name = "terraform-webserver"
    }
}