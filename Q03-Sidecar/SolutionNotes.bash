# Get current deployment

k get deployment

k get deployment synergy-leverager -o yaml > q3.yaml

# search kube doco for sidecar, it will show the volume mount

apiVersion: apps/v1
kind: Deployment
metadata:
  name: synergy-leverager
spec:
  template:
    spec:
      volumes:
      - name: data
        emptyDir: {}
      containers:
      - name: synergy-leverager
        command: ["/bin/sh", "-c", "while true; do echo 'WordPress is running...' >> /var/log/synergy-leverager.log; sleep 5; done"]
        volumeMounts:
        - name: data
          mountPath: /var/log
      - name: sidecar
        image: busybox:stable
        command: ["/bin/sh","-c","tail -f /var/log/wordpress.log"]
        volumeMounts:
        - name: data
          mountPath: /var/log

# apply
k apply -f q3.yaml

#check 
k get pods
k logs <pod-name> 

