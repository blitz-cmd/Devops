# Creating k8s microservices, managing with Istio & integrating it with Kiali and Grafana dashboard

### Create kops cluster(master should be of medium type)
```
$ kops create cluster --yes --state=s3://<bucket_name> --zones=ap-south-1a --node-size=t2.medium --master-size=t2.medium --master-count 1 --node-count 2 --name=test.k8s.local
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
### Deploy sample webapp 
```
$ wget https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml
$ kubectl create -f bookinfo.yaml
$ kubectl get services
$ kubectl get pods
$ kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
```
### Open the application to outside traffic
```
$ wget https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/networking/bookinfo-gateway.yaml
$ kubectl create -f bookinfo-gateway.yaml
$ istioctl analyze      #No validation issues found when analyzing namespace: default.
$ kubectl get svc istio-ingressgateway -n istio-system
```
### Add Kiali dashboard
```
$ wget https://raw.githubusercontent.com/istio/istio/release-1.11/samples/addons/kiali.yaml
$ kubectl create -f kiali.yaml
$ kubectl rollout status deployment/kiali -n istio-system
$ istioctl dashboard kiali
```

### Delete
$ kops delete cluster --name=test.k8s.local --yes --state=s3://<bucket_name>