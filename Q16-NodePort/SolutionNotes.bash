# Add container port to deployment

k get deployment nodeport-deployment -n relative -o yaml > q16.yaml

      spec:
        containers:
        - image: nginx
          imagePullPolicy: Always
          name: nginx
          ports:
          - containerPort: 80
            name: http
            protocol: TCP
          resources: {}
          
#this will get a warning, but will do it

k apply -f q16.yaml

# Create NodePort service on 30080
cat <<'EOF' > svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: nodeport-service
  namespace: relative
spec:
  type: NodePort
  selector:
    app: nodeport-deployment
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    nodePort: 30080
EOF

kubectl apply -f svc.yaml
kubectl get svc nodeport-service -n relative -o wide
# Test: curl http://<nodeIP>:30080
