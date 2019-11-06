# Postgres Kubernetes

We use the https://postgres-operator.readthedocs.io/en/latest/ operator


## Access the database

```bash

export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials -o 'jsonpath={.data.password}' | base64 -d)
export PGHOST="localhost"
export PGPORT="5432"

kubectl port-forward service/acid-minimal-cluster-repl 5432:5432

psql -U postgres


```
