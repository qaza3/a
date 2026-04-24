# Check apiserver logs, fix etcd endpoint
journalctl -u kube-apiserver | tail
# look for failed starts
crictl ps -a
crictl logs <falied-container-id>

# Ensure flag uses correct etcd port
# --etcd-servers=https://127.0.0.1:2379

sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml   # correct port/IP, save and wait for static pod restart

# It quite often will not restart
systemctl restart kublet
