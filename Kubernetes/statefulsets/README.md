# For creating statefulsets 

```
kops create cluster --yes --state=s3://<name_of_the_bucket> --zones=ap-south-1a --node-size=t2.small --master-size=t2.small --name=test.k8s.local
```
### Save your manifest file
```
nano cassandra.yml                                                              
```
```
kubectl create -f <manifestfile_name>
```
### Live preview of pod status
```
watch kubectl get pod                                                           
```
### Get details of seed node of cassandra
```
kubectl exec -it cassandra-0 -- nodetool status 
```
### For deleting statefulsets, first we have to set replica to 0 to remove all running pods, then we hac=ve to delete it
### 1st set replica to 0
```
kubectl edit StatefulSet cassandra  
```
### View all statefulsets
```
kubectl get StatefulSet                                                         
```
### Delete statefulsets
```
kubectl delete StatefulSet cassandra
```
### Delete statefulsets will not delete persistent volume
### To delete we have to define it explicitly
```
kubectl get pvc
```
```
kubectl delete pvc <pvc_name>
or
kubectl delete pvc --all
```