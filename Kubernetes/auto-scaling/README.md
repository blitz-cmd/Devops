# Creating auto-scalable cluster

### Create kubernetes cluster if doesn't exist
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
$kubectl create -f autoscale.yml
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

### While running above last command you will get <unknown> option in target column
### For that we need to install metric server

### First delete any existing metric server
```
$ kubectl delete -n kube-system deployments.apps metrics-server
```
### Get metric server from github
```
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```
### To verify all running pods
```
kubectl -n kube-system get pods
```
### Delete cluster
```
$ kops delete cluster --name=<cluster_name> --yes --state=s3://<bucket_name>
```