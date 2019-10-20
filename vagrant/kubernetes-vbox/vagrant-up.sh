#!/bin/bash
set -e
#looks like vagrant is asynchronous, so all vms are upped at the same time
# and slaves don't have a chance to connect to the master cuz its not configured yet
# so we need to up master first

vagrant up k8s-master
vagrant up

