#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${cluster_name} \
  --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot,eks.amazonaws.com/nodegroup=${node_group_name}'
