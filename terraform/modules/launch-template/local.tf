locals {

  frontend_user_data = <<-EOF
#!/bin/bash

dnf update -y
dnf install docker -y

systemctl enable docker
systemctl start docker

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 302263046564.dkr.ecr.ap-south-1.amazonaws.com

docker pull 302263046564.dkr.ecr.ap-south-1.amazonaws.com/frontend-app:latest

docker run -d -p 80:80 302263046564.dkr.ecr.ap-south-1.amazonaws.com/frontend-app:latest
EOF

  backend_user_data = <<-EOF
#!/bin/bash

dnf update -y
dnf install docker -y

systemctl enable docker
systemctl start docker

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 302263046564.dkr.ecr.ap-south-1.amazonaws.com

docker pull 302263046564.dkr.ecr.ap-south-1.amazonaws.com/backend-api:latest

docker run -d -p 8000:8000 302263046564.dkr.ecr.ap-south-1.amazonaws.com/backend-api:latest
EOF

}