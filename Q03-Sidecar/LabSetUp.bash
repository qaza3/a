#!/bin/bash
set -e

echo "🚀 Setting up WordPress deployment for sidecar lab in the default namespace..."

# 1. Create WordPress deployment without log volume
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: synergy-leverager
  labels:
    app: synergy-leverager
spec:
  replicas: 1
  selector:
    matchLabels:
      app: synergy-leverager
  template:
    metadata:
      labels:
        app: synergy-leverager
    spec:
      containers:
      - name: synergy-leverager
        image: wordpress:php8.2-apache
        command: ["/bin/sh", "-c", "while true; do echo 'WordPress is running...' >> /var/log/synergy-leverager.log; sleep 5; done"]
        ports:
        - containerPort: 80
EOF

# 2. Create a service to expose the deployment
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: synergy-leverager
spec:
  selector:
    app: synergy-leverager
  ports:
  - port: 80
    targetPort: 80
EOF

echo
echo "✅ Lab setup complete!"
echo
echo "WordPress deployment created in the default namespace."
echo "You can now edit the deployment to add the sidecar container and shared volume."
