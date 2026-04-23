
k get pv -o wide -n mariadb
- ^^^ check what is there

search kube doco 'pcv'
click 'Persistent Volumes - Kubernetes'
search 'kind: persistentvolumeclaim'
second example is best 2/9
 
- change 'name'
- add    'namespace' 
- change 'storage'
- change 'volumeMode'
- change 'storageClassName'

^^^ changes to output from pv

save as q1.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mariadb
  namespace: mariadb
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 250Mi
  storageClassName: standard

Apply
k apply -f q1.yaml

Check its bound
k get pv -n mariadb -o wide

Change deployment
- add the volume claim

Check pod
k describe pod mariadb -n mariadb
