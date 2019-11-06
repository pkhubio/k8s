#!/usr/bin/env bash

DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

set -e

export NAME=k8s.pkhub.io
export KOPS_STATE_STORE=s3://k8s-pkhub-io-state-store

create () {
cd "$DIR"

kops create cluster \
    --node-count 2 \
    --master-count 1 \
    --zones eu-west-1a,eu-west-1b,eu-west-1c \
    --master-zones eu-west-1a \
    --dns-zone k8s.pkhub.io \
    --node-size t3.medium \
    --master-size t3.micro \
    --topology private \
    --networking weave \
    --cloud-labels "Env=Prod,Owner=pkhub" \
    --image "amazon/amzn2-ami-hvm-2.0.20191024.3-x86_64-gp2" \
    --bastion \
    ${NAME}
}

delete () {
 cd "$DIR"
 kops delete cluster k8s.pkhub.io --yes
}

_kubectl () {


FILE="$HOME/pk-kubeconfig.yaml"

if [[ ! -f "$FILE" ]];
then
 echo "Exporting kube config"
 kops export kubecfg --name k8s.pkhub.io --kubeconfig "$FILE"
 echo "DONE: see $FILE"
fi

export KUBECONFIG="$FILE"

kubectl $@

}

CMD="$1"
shift

case "$CMD" in
    kubectl )
    _kubectl "$@"
    ;;
    groups )
    kops get instancegroups
	;;
	delete )
	delete
	;;
	create )
	create
	;;
	apply )
	kops update cluster --name k8s.pkhub.io --yes
        ;;
        validate )
	kops validate cluster
	;;
	nodes )
	kubectl get nodes --show-labels
	;;
        bastion )
	ssh -A -i ~/.ssh/id_rsa ec2-user@bastion.k8s.pkhub.io
	;;
        * )
	echo "done"
	;;
esac

