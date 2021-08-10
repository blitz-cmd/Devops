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
### Get all context lists
```
$ kubectl config get-contexts
```
### For creating rbac 1st we need to retrieve kops key
```
$ aws s3 sync s3://<bucket_name>/<cluster_name>/pki/private/ca/ ca-key
$ aws s3 sync s3://<bucket_name>/<cluster_name>/pki/issued/ca/ ca-crt
```
### & then move the folder to particular key
```
$ mv ca-key/*.key ca.key
$ mv ca-crt/*.crt ca.crt
```
### 2nd we need to create new user(example we will create \"peter\" user & we have also declared peter in rbac.yml file)
```
$ sudo apt install openssl
$ openssl genrsa -out peter.pem 2048
$ openssl req -new -key peter.pem -out peter-csr.pem -subj "/CN=peter/O=myteam/"
$ openssl x509 -req -in peter-csr.pem -CA ca.crt -CAkey ca.key -CAcreateserial -out peter.crt -days 10000
```
### At last we need to add new context
```
$ kubectl config set-credentials peter --client-certificate=peter.crt --client-key=peter.pem
$ kubectl config set-context peter --cluster=level360degree.uk --user peter
```
### Get context list & set context list to peter
```
$ kubectl config get-contexts
$ kubectl config use-context peter
```