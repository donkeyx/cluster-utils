# 🐴 DonkeyX's Cluster Utils

```
╭────────────────────────────────────────╮
|         🐴 DonkeyX's Cluster Utils      │
╰────────────────────────────────────────╯

        //\\
       (/oo\)   .----.
       (____)  | K8s |
        /||\   '----'
       //||\\   🐛 Debug Mode
      ^^ ^^ ^^
   "Braying at broken clusters!"
```

## Description

A modern, lightweight Docker container designed for Kubernetes cluster debugging and network troubleshooting. Built on Alpine Linux with a comprehensive toolkit for testing network routes, DNS resolution, database connections, and service mesh configurations.

**Key Features:**
- 🚀 **Runs Continuously** - No timeouts, persistent debugging environment
- 🎨 **Beautiful Welcome** - Colorized interface with tool inventory
- 🐚 **Modern Shell** - Zsh with Oh My Zsh for enhanced productivity  
- 🔧 **Latest Tools** - Automatically fetches latest versions (k6, etc.)
- 📦 **Optimized Size** - Single-layer build, minimal footprint (~220MB)

* **Container Registry**: `ghcr.io/donkeyx/cluster-utils:latest` or `donkeyx/cluster-utils:latest`

## 🚀 Usage

### Deploy to Kubernetes Cluster

Deploy as a **Deployment** (runs continuously, no timeouts):

```bash
# Deploy the cluster utilities as a persistent deployment
kubectl apply -f https://raw.githubusercontent.com/donkeyx/cluster-utils/master/k8s-cluster-utils.yml

# Check the deployment
kubectl get deployments
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
cluster-utils   1/1     1            1           30s

# List the pod
kubectl get pods -l app=cluster-utils
NAME                             READY   STATUS    RESTARTS   AGE
cluster-utils-7b8c9d4f5d-x9k2j   1/1     Running   0          45s
```

### Connect to the Container

Multiple ways to connect - **all automatically give you zsh**:

```bash
# Any of these will give you zsh with the welcome message:
kubectl exec -it deployment/cluster-utils -- sh
kubectl exec -it deployment/cluster-utils -- zsh  
kubectl exec -it deployment/cluster-utils -- /bin/sh

# You'll see the welcome screen:
╭────────────────────────────────────────╮
|         🐴 DonkeyX's Cluster Utils      │
╰────────────────────────────────────────╯

        //\\
       (/oo\)   .----.
       (____)  | K8s |
        /||\   '----'
       //||\\   🐛 Debug Mode
      ^^ ^^ ^^
   "Braying at broken clusters!"

🚀 Welcome to the Kubernetes Cluster Utilities! 🚀
=====================================================

📦 Available Tools:

🌐 Network & DNS:
  • dig, nslookup, host (bind-tools)
  • nc (netcat-openbsd)  
  • curl, wget

🗄️  Database Clients:
  • psql (PostgreSQL client v17.6)
  • redis-cli (Redis client)

🛠️  Development & Utilities:
  • git (version control)
  • jq (JSON processor)
  • vim (text editor)
  • tmux (terminal multiplexer)
  • npm/node (JavaScript runtime)

⚡ Load Testing:
  • k6 (latest version - auto-updated)

🐚 Shell Environment:
  • zsh with Oh My Zsh
  • Custom prompt and completions
```


## 🔨 Local Development

### Build Image Locally

```bash
# Clone the repository
git clone https://github.com/donkeyx/cluster-utils.git
cd cluster-utils

# Build with Docker or Podman
docker build -t cluster-utils:local .
# OR
podman build -t cluster-utils:local .

# Run locally for testing
docker run -d --name cluster-utils-test cluster-utils:local
docker exec -it cluster-utils-test sh  # Automatically switches to zsh!
```

### Container Runtime Options

```bash
# Run with Docker
docker run -d --rm --name cluster-utils donkeyx/cluster-utils:latest

# Run with Podman  
podman run -d --rm --name cluster-utils donkeyx/cluster-utils:latest

# Connect (any of these work - all give you zsh):
docker exec -it cluster-utils sh
podman exec -it cluster-utils zsh
kubectl exec -it deployment/cluster-utils -- /bin/sh
```

## 🧰 Available Tools & Commands

### Network Diagnostics
```bash
# Check if port is open
nc -z -v -w5 10.1.1.51 8080

# DNS resolution  
dig google.com
nslookup my-service.default.svc.cluster.local

# HTTP testing
curl -v https://api.example.com
wget --spider https://my-service/health
```

### Database Testing
```bash
# PostgreSQL connection
psql -h postgres-host -U username -d database

# Redis testing
redis-cli -h redis-host ping
redis-cli -h redis-host info server
```

### Load Testing
```bash
# k6 load testing (latest version auto-installed)
k6 run --vus 10 --duration 30s script.js
k6 run --http-debug https://api.example.com
```

### Container & Kubernetes Debugging
```bash
# Check container environment
env | grep KUBERNETES
cat /var/run/secrets/kubernetes.io/serviceaccount/namespace

# Network troubleshooting within cluster
nc -z -v service-name 80
dig service-name.namespace.svc.cluster.local
```

## 🎯 Key Improvements

- **No Timeouts**: Container runs continuously until manually stopped
- **Modern Tools**: Latest k6, PostgreSQL 17.6, npm instead of full Node.js
- **Optimized Size**: ~220MB (removed MongoDB tools, optimized layers)  
- **Better UX**: Auto-switches to zsh, colorized welcome, tool inventory
- **Deployment Ready**: Kubernetes Deployment (not Job) for persistence
- **Multi-Shell Support**: Works with `sh`, `zsh`, or `bash` connections

## 🐴 Why "Braying at Broken Clusters"?

Because sometimes your clusters are stubborn as a mule, and you need the right tools to debug them! This container gives you everything you need to troubleshoot network issues, test services, and get your Kubernetes clusters working smoothly again. 🎯
