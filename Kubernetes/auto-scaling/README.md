# Creating auto-scalable cluster

## Note: Your ssh terminal should be configure with AWS access key & secret key with Administrative Permission

### To cross-verify AWS config
```
$ aws configure list
```
### Create a S3 bucket for storing the cluster configs

### Create kubernetes cluster if doesn't exist (generally take 5-10 mins)
```
$ kops create cluster --yes --state=s3://<s3_bucket_name> --zones=ap-south-1a --node-size=t2.micro --master-size=t2.micro --name=test.k8s.local
```
### Verify the cluster & wait till the status is ready
```
$ kops validate cluster --state=s3://<s3_bucket_name>
```
### Create manifest file for deployment & service and deploy it
```
$ nano autoscale.yml
$ kubectl create -f autoscale.yml
```
### To watch live status to below services
```
$ kubectl get service,hpa,pod,deployment -owide
$ watch -n1 !!
```
### Create HPA(Horizontal Pod Autoscaler) for the deployment
```
$ kubectl autoscale deployment <deployment_name> --min=2 --max=10 --cpu-percent=50
```
### (Optional) To verify the hpa
```
$ kubectl describe hpa
$ kubectl get hpa
```

### While running above last command you will get \<unknown\> option in target column
### For that we need to install metric server

### First delete any existing metric server
```
$ kubectl delete -n kube-system deployments.apps metrics-server
```
### Get metric server from github
```
$ wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```
### Edit the components.yaml to bypass TLS certificate
```
- name: metrics-server
    image: k8s.gcr.io/metrics-server-amd64:v0.3.1
    command:
    - /metrics-server
    - --kubelet-insecure-tls
 ```
### Create the above components.yaml file
```
$ kubectl create -f components.yaml
```
### To view all running pods(metrics server will take some time to spin up)
```
kubectl -n kube-system get pods
```
### To get log of metric-server
```
$ kubectl -n kube-system logs <from_above_metric_server_name>
```

### While running the above command there will be an error \"Failed to scrape node or Failed probe" probe="metric-storage-ready" err="not metrics to serve"
### To remove that error, we need to add webhook in the cluster

### Edit cluster
```
$ kops edit cluster --state=s3://<bucket_name>
```
### Add following lines
```
kubelet:
  anonymousAuth: false
  authenticationTokenWebhook: true
  authorizationMode: Webhook
```
### Update cluster 
```
$ kops update cluster --state=s3://<bucket_name> <cluster_name> --yes
```
### Roll the update(min 10min to rollup)
```
$ kops rolling-update cluster --state=s3://<bucket_name> <cluster_name> --yes
```
### Get all nodes
```
$ kubectl get nodes
```
### Check memory consumption by these nodes
```
$ kubectl top nodes
```

## To demonstrate auto-scalling
### Run below command
```
$ kubectl run -i --tty busy-box --image=busybox /bin/sh
$ wget http://hpa-example.default.svc.cluster.local:31010
$ while true; do wget -q -O- http://hpaexample.default.svc.cluster.local:31010; done
```

### Delete cluster
```
$ kops delete cluster --name=<cluster_name> --yes --state=s3://<bucket_name>
```