# RBAC(Role Based Access Control)
### To verify RBAC(rbac.authorization.* will be present)
```
$ kubectl api-versions
```
### If not present, we can add it during cluster creation time
```
$ kops create cluster --yes --state=s3://kops-504 --zones=ap-south-1a --node-size=t2.micro --master-size=t2.micro --authorization=RBAC --name=test.k8s.local

OR

$ minikube start --extra-config=apiserver.Authorization.Mode=RBAC
```
### Create rbac.yml
### Get all cluster
```
$ kubectl config get-contexts
```