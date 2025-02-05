# Terraform Web Server Project

This project demonstrates how to deploy a simple web server on AWS using Terraform. The web server is configured to host a basic HTML page using the Apache HTTP server.

# Project Overview

This project automatically services and packages like an EC2 instance, installs a web server (Apache), and deploys a simple HTML webpage with the message:

"Im Jash , This is my first time hosting an webserver using terraform" - > You can put any message you want to be displayed on the Webpage 


# Beneficial Features:

1. The infrastructure here is automated using terraform
2. Apache server (HTTP) is installed using the user data command in terraform
3. Security Groups are being configured on our purpose and here all the protocols are being allowed

# Structure of terraform files:
- main.tf
- variables.tf
- outputs.tf
- providers.tf

# Infrastructure details:

1. Instance type used : "t2.micro"
2. OS used : Amazon Linux 2
3. Web Server : Apache HTTP server
4. ingress - Port 80
5. egress - anywhere and all protocols allowed



