# Resource Quota
### To get resource details, we need to install metrics server
#### PS:using minikube
```
$ minikube addons enable metrics-server
```
### Get memory details of pods & nodes
```
$ kubectl top pod
$ kubectl top nodes
```
### Create resource quota for the node
```
kubectl create -f resourcequota-namespace.yml
```
### Try to create deployment without limits
### Get details on namespace
```
$ kubectl get namespace
$ kubectl get resourcequota --namespace=mynamespace
$ kubectl get rs --namespace=mynamespace
$ kubectl describe rs --namespace=mynamespace
```
### You will get an error \"must specify limit\" in describe rs cmd
### Now try to create deployment without limit
### Now get details on namespace & it will be create successfully

### To deploy deployments without limits
### We need to create default deployment limit which will attach to deployment that contains no limit specs
```
$ kubectl create -f def-deploylim.yml
```
### Now you can create deployments without limits