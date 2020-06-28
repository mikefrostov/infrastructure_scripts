#!/bin/bash

#run temp registry in a ct 
docker run -d -p 5000:5000 --restart=always --name registry registry:2

#build and push docker registry image to a temp registry so it may be accessible from k8s
mkdir ~/k8s-registry
git clone https://gitlab.com/gitlab-org/container-registry.git
cd container-registry
sudo docker build -t localhost:5000/registry:dev .
sudo docker push localhost:5000/registry:dev



