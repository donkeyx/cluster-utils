# 🐴 DonkeyX's Cluster Utils

```
╭────────────────────────────────────────╮
|    🐴 DonkeyX's Cluster Utils         │
╰────────────────────────────────────────╯

        //\\
       (/oo\)   .----.
       (____)  | K8s |
        /||\   '----'
       //||\\   🐛 Debug Mode
      ^^ ^^ ^^
   "Lets break some Shit!"
```

## Description

A modern, lightweight Docker container designed for Kubernetes cluster debugging and network troubleshooting. Built on Alpine Linux with a comprehensive toolkit for testing network routes, DNS resolution, database connections, and service mesh configurations.

**Key Features:**
- 🚀 **Runs Continuously** - No timeouts, persistent debugging environment
- 🎨 **Beautiful Welcome** - Colorized interface with tool inventory
- 🐚 **Modern Shell** - Zsh with Oh My Zsh for enhanced productivity  
- 🔧 **Latest Tools** - Automatically fetches latest versions (k6, etc.)
- 📦 **Optimized Size** - Single-layer build, minimal footprint (~220MB)

* **Container Registry**: `ghcr.io/donkeyx/cluster-utils:latest` (GitHub) or `donkeyx/cluster-utils:latest` (DockerHub)

## 🚀 Usage

### Quick Interactive Access (Local)

For immediate interactive shell access without deployment:

```bash
# Interactive shell (with explicit zsh entry)
docker run -it --rm --entrypoint=/bin/zsh ghcr.io/donkeyx/cluster-utils:latest

# Alternative: Let auto-shell switching handle it (sh → zsh automatically)  
docker run -it --rm --entrypoint=/bin/sh ghcr.io/donkeyx/cluster-utils:latest

# Note: Replace 'docker' with 'podman' if using Podman instead
```

**What you get:**
- ✅ Immediate zsh shell with Oh My Zsh
- ✅ Welcome screen with ASCII donkey and tool inventory
- ✅ All debugging tools ready to use  
- ✅ Auto-cleanup when you exit (`--rm`)

### Deploy to Kubernetes Cluster

Deploy as a **Deployment** (runs continuously, no timeouts):

```bash
# Deploy the cluster utilities as a persistent deployment
kubectl apply -f https://raw.githubusercontent.com/donkeyx/cluster-utils/master/k8s-cluster-utils.yml

# Check the deployment and service
kubectl get deployments,services -l app=cluster-utils
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cluster-utils   1/1     1            1           30s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/cluster-utils   ClusterIP   10.96.45.123   <none>        8080/TCP   30s
```

### Connect to Deployed Container

**Easy connection via service (no need to know pod name!):**

```bash
# Connect using the service - simplest method:
kubectl exec -it service/cluster-utils -- sh
kubectl exec -it service/cluster-utils -- zsh

# Alternative: Connect via deployment:
kubectl exec -it deployment/cluster-utils -- sh
kubectl exec -it deployment/cluster-utils -- zsh

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

## 🎯 **Two Usage Modes**

| Mode | Use Case | Command Pattern |
|------|----------|-----------------|
| **Interactive** | Quick local debugging, testing tools | `docker run -it --rm --entrypoint=/bin/zsh ...` |
| **Deployment** | Persistent cluster pod, team access | `kubectl apply -f k8s-cluster-utils.yml` |

### Deploy to Kubernetes Cluster
```


## 🔨 Local Development

### Build Image Locally

```bash
# Clone the repository
git clone https://github.com/donkeyx/cluster-utils.git
cd cluster-utils

# Build the image
docker build -t cluster-utils:local .

# Run locally for testing
docker run -d --name cluster-utils-test cluster-utils:local

# Connect to test container (automatically switches to zsh!)
docker exec -it cluster-utils-test sh

# Note: All commands work with Podman by replacing 'docker' with 'podman'
```

### Container Runtime Options

```bash
# Run with Docker (GitHub Container Registry - recommended)
docker run -d --rm --name cluster-utils ghcr.io/donkeyx/cluster-utils:latest

# Alternative: DockerHub registry
docker run -d --rm --name cluster-utils donkeyx/cluster-utils:latest

# Connect to running container (any shell command gives you zsh):
docker exec -it cluster-utils sh
docker exec -it cluster-utils zsh

# Kubernetes connections (easiest with service):
kubectl exec -it service/cluster-utils -- sh
kubectl exec -it deployment/cluster-utils -- sh

# Note: Podman users can replace 'docker' with 'podman' in all commands
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
