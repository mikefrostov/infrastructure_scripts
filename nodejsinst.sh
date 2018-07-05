#!/bin/bash
set -e
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
yum install nodejs
yum install gcc-c++ make
