# Serverless in k8s using kubeless
### https://kubeless.io/docs/quick-start/

### Create kops cluster and validate it(after 10mins)
```
$ kops create cluster --yes --state=s3://<bucket_name> --zones=ap-south-1a --node-size=t2.micro --master-size=t2.micro --name=test.k8s.local
$ kops validate cluster --state=s3://<bucket_name>
```
### Install kubeless from their official github
#### - first need to create RELEASE & OS path variable to get latest release and os details
#### - then we can echo the adjacent variable
#### - after that download the kubeless from github....unzip it....then mv the file to binanry dir
```
$ export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
$ echo $RELEASE
$ export OS=$(uname -s| tr '[:upper:]' '[:lower:]')
$ echo $OS
$ curl -OL https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless_$OS-amd64.zip
$ unzip kubeless_$OS-amd64.zip
$ sudo mv bundles/kubeless_$OS-amd64/kubeless /usr/local/bin/
```
### Create kubeless namespace
```
$ kubectl create ns kubeless
$ kubectl get ns
```
### Create a sample yaml file from kubeless release pg
```
$ kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml
```
### Get details
```
$ kubectl get pods -n kubeless
$ kubectl get deployment -n kubeless
$ kubectl get customresourcedefinition
```
### Create sample function
```
$ nano hello.py
def hello(event, context):
  print(event)
  return event['data']
```
### Deploy this function
```
$ kubeless function deploy hello --runtime python<python_version> --from-file hello.py --handler test.hello
```
### Get details
```
$ kubectl get functions
$ kubeless function ls
$ kubeless function describe hello
```
### Calling the function
```
$ kubeless function call hello --data 'Hello world!'
```
### Cleanup
```
$ kubeless function delete hello
$ kubectl delete -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml
```
### Delete cluster
```
$ kops delete cluster --name=test.k8s.local --yes --state=s3://<bucket_name>
```