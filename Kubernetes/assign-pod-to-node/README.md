# Node Selector
### nodeSelector is the simplest recommended form of node selection constraint. nodeSelector is a field of PodSpec. It specifies a map of key-value pairs. For the pod to be eligible to run on a node, the node must have each of the indicated key-value pairs as labels (it can have additional labels as well).

# Node Affinity
### Node affinity is conceptually similar to \'nSelector\' it allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on the node. It is similar to nodeSelector but using a more expressive syntax

## Types
### requiredDuringSchedulingIgnoredDuringExecution
### preferredDuringSchedulingIgnoredDuringExecution
### (Future)requiredDuringSchedulingRequiredDuringExecution

