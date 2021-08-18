# Creating k8s microservices, managing with Istio & integrating it with Kiali and Grafana dashboard

### Create kops cluster
```
$ kops create cluster --yes --state=s3://<bucket_name> --zones=ap-south-1a --node-size=t2.medium --master-size=t2.micro --master-count 1 --node-count 2 --name=test.k8s.local
$ kops validate cluster --state=s3://<bucket_name>
```
### Install Istio using Istioctl
```
$ curl -L https://istio.io/downloadIstio | sh -
$ cd istio-1.11.0
$ export PATH=$PWD/bin:$PATH
$ istioctl install --set profile=demo -y
$ kubectl label namespace default istio-injection=enabled
```
### Install sample webapp 
```
$ kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml
$ kubectl get services
$ kubectl get pods


### Delete
$ kops delete cluster --name=test.k8s.local --yes --state=s3://<bucket_name>