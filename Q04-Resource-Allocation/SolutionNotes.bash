# Step 1: pause workload
kubectl scale deployment wordpress --replicas 0

# Step 2: edit deployment (set same resources on all init + main containers)
k get deployment/wordpress.app -o yaml > q4.yaml

kubectl edit deployment wordpress

# search kube doco for 'resource'

# In spec
      containers:
      - image: wordpress:6.2-apache
        imagePullPolicy: IfNotPresent
        name: wordpress
        ports:
        - containerPort: 80
          protocol: TCP
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "300m"

# (Values are just an example of dividing the node evenly and keeping some headroom;
# ensure every container—init and main—uses the exact same requests/limits.)

# Step 3: resume replicas
kubectl scale deployment wordpress --replicas 3
kubectl rollout status deployment wordpress
kubectl get pods -l app=wordpress
