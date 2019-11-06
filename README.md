# PKHub dev kops cluster

Follow the steps for setting up a kops cluster from the https://github.com/kubernetes/kops repo.


Remember to upgrade to the latest kops client.

# Usage

See: `bin/kubectl`

# Setup Details

## DNS

The subdomain `k8s` is setup in cloud flare to point to the AWS route 53 `k8s.pkhub.io` hosted zone.

Kops requires `Route53` managed dns.

## K8S

A single master is used. When a master fails applications would not fail unless the pods are killed during the 
time the master is down.

## Update or edit the cluster

See the `bin/kops-cluster.sh` script

  * Update: `bin/kopds-cluster.sh update`
  * Validate the cluster: `bin/kopds-cluster.sh validate`
  * List nodes: `bin/kopds-cluster.sh nodes`
  * Ssh into the bastion: `bin/kopds-cluster.sh bastion`
  * Apply any changes: `bin/kopds-cluster.sh apply`
      
    
