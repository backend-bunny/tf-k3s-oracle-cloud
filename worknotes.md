https://github.com/garutilorenzo/k3s-oci-cluster/blob/master/lb.tf



cilium helm values
```yaml
operator:
    replicas: 2
ipam:
    mode: kubernetes
k8sServiceHost: 127.0.0.1
k3sServicePort: 7445
securityContext:
    capabilites:
        ciliumAgent:
            - CHOWN
            - KILL
            - NET_ADMIN
            - NET_RAW
            - IPC_LOCK
            - SYS_ADMIN
            - SYS_RESOURCES
            - DAC_OVERRIDE
            - FOWNER
            - SETGID
            - SETUID
        cleanCiliumState:
            - NET_ADMIN
            - SYS_ADMIN
            - SYS_RESOURCES
    cgroup:
        autoMount:
            enabled: false
        hostRoot: /sys/fs/cgroup
```