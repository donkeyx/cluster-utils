# cluster-utils

## Description

Sample docker image to give you a bash session into your cluster, with lots of tools for testing
network routes etc. I find it super handy when i am testing istio routes/dns and security group
access.

This container will by default run for 30mins before exiting. You can override this behavior
by modifying the env param ```RUNTIME=1234```. This can be done in the kubes pod definition or
passed to docker at runtime.

## Usage

### run image in k8 cluster:

You can run the pod in your cluster with the commands below, this will start the container
in the default namespace and timeout in 30mins.
```bash
# apply pod config with default 30min timeout
kubectl -n default \
    apply -f https://raw.githubusercontent.com/donkeyx/cluster-utils/master/k8s-cluster-utils.yml

# list the pod
$ kubectl get pods -n default
NAME            READY   STATUS    RESTARTS   AGE
cluster-utils   1/1     Running   0          2m18s
```

Now the pod is running, you can exec into it and.. do whatever you need within the context of
your cluster/namespace.
```bash
# jump into container with zsh shell + ohmyzsh
        ................           root@5341f0387b50
       ∴::::::::::::::::∴          OS: Alpine Linux
      ∴::::::::::::::::::∴         Kernel: x86_64 Linux 4.19.76-linuxkit
     ∴::::::::::::::::::::∴        Uptime: 6d 19h 30m
    ∴:::::::. :::::':::::::∴       Packages: 67
   ∴:::::::.   ;::; ::::::::∴      Shell: ash
  ∴::::::;      ∵     :::::::∴     Disk:  /  ()
 ∴:::::.     .         .::::::∴    CPU: Intel Core i7-7700HQ @ 4x 2.8GHz
 ::::::     :::.    .    ::::::    RAM: 463MiB / 1991MiB
 ∵::::     ::::::.  ::.   ::::∵
  ∵:..   .:;::::::: :::.  :::∵
   ∵::::::::::::::::::::::::∵
    ∵::::::::::::::::::::::∵
     ∵::::::::::::::::::::∵
      ::::::::::::::::::::
       ∵::::::::::::::::∵

```


### Build image locally:

You can build the image locally if you like and then push to your own repo for testing

```bash
# clone repo
git@github.com:donkeyx/cluster-utils.git
cd cluster-utils

# build and tag
docker build . -t donkeyx/cluster-utils

# push
docker push YOUR_REPO.../cluster-utils:latest
```

### Start container:

Follow the build process above
```bash

$ docker run -e RUNTIME=60 -d --rm --name cluster-utils donkeyx/cluster-utils
1a3b19d75ab9a536ff531935e9da9f9c549d288cb0cab0d6bbdda2249b4ea680

$ docker ps
CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS              PORTS               NAMES
1a3b19d75ab9        donkeyx/cluster-utils   "sh /tmp/sleeper.sh"   3 seconds ago       Up 3 seconds                            cluster-utils

$ docker exec -it cluster-utils zsh
➜  /tmp

```

### Some useful command and packages available

```bash

# check port is open
nc -z -v -w5 10.1.1.51 8080

# check dns
dig google.com

# traceroute path for request
traceroute my-internal-service.com

```
