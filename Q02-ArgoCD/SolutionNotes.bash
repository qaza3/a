# Create namespace
kubectl create namespace argocd

# Add repo and template manifests (CRDs not installed)
helm repo add argocd https://argoproj.github.io/argo-helm
helm repo update
helm search repo argocd
helm template argocd argo/argo-cd --version 7.7.3 --set crds.install=false --namespace argocd > /root/argo-helm.yaml
cat /root/argo-helm.yaml   # confirm output

#install
k apply -f /root/argo-helm.yaml

#install using helm
helm install argocd argo/argo-cd --version 7.7.3 --set crds.install=false --namespace argocd
