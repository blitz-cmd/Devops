#for creating statefulsets 

kops create cluster --yes --state=s3://<name_of_the_bucket> --zones=ap-south-1a --node-size=t2.small --master-size=t2.small --name=test.k8s.local

nano cassandra.yml                                                              #save your manifest file

kubectl create -f <manifestfile_name>

watch kubectl get pod                                                           #live preview of pod status

kubectl exec -it cassandra-0 -- nodetool status                                 #get details of seed node of cassandra

#for deleting statefulsets, first we have to set replica to 0 to remove all running pods

kubectl edit StatefulSet cassandra  #set replica to 0

kubectl get StatefulSet                                                         #view all statefulsets

kubectl delete StatefulSet cassandra

#delete statefulsets will not delete persistent volume
#to delete we have to define explicitly

kubectl get pvc

kubectl delete pvc <pvc_name>
or
kubectl delete pvc --all