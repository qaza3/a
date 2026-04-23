# Create PriorityClass just below existing max (e.g., 999)
kubectl create priorityclass high-priority --value=999 --description="high priority"
kubectl get pc

# Patch deployment to use it
kubectl patch deployment busybox-logger -n priority -p '{"spec":{"template":{"spec":{"priorityClassName":"high-priority"}}}}'
kubectl describe deployment busybox-logger -n priority | grep -i "Priority Class"

or

apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 999
globalDefault: false

k get deployment busybox-logger -n priority -o yaml > q7_dep.yaml

add in line 
...
template:
        metadata:
          labels:
            app: busybox-logger
        spec:
          containers:
          - command:
            - sh
            - -c
            - while true; do echo 'logging...'; sleep 5; done
            image: busybox
            imagePullPolicy: Always
            name: busybox
            resources: {}
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirst
          priorityClassName: high-priority
          restartPolicy: Always
          schedulerName: default-scheduler
...
