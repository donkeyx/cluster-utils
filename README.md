# cluster-utils-api

## description

Sample docker image to give you a bash session into your cluster, with lots of tools for testing
network routes etc. I find it super handy when i am testing iotio routes/dns and security group
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
    apply -f https://raw.githubusercontent.com/donkeyx/docker_cluster-utils/master/k8s-cluter-utils.yml

# list the pod
$ kubectl get pods -n default
NAME            READY   STATUS    RESTARTS   AGE
cluster-utils   1/1     Running   0          2m18s
```

Now the pod is running, you can exec into it and.. do whatever you need within the context of
your cluster/namespace.
```bash
# jump into container with zsh shell + ohmyzsh
kubectl -n default exec -it cluster-utils zsh
awk: cannot open /proc/fb (No such file or directory)
                          ./+o+-       root@cluster-utils
                  yyyyy- -yyyyyy+      OS: Ubuntu 18.04 bionic
               ://+//////-yyyyyyo      Kernel: x86_64 Linux 4.14.150+
           .++ .:/++++++/-.+sss/`      Uptime: 16h 32m
         .:++o:  /++++++++/:--:/-      Packages: 390
        o:+o+:++.`..```.-/oo+++++/     Shell: zsh 5.4.2
       .:+o:+o/.          `+sssoo+/    CPU: Intel Xeon @ 2.2GHz
  .++/+:+oo+o:`             /sssooo.   GPU:
 /+++//+:`oo+o               /::--:.   RAM: 708MiB / 3697MiB
 \+/+o+++`o++o               ++////.
  .++.o+++oo+:`             /dddhhh.
       .+.o+oo:.          `oddhhhh+
        \+.++o+o``-````.:ohdhhhhh+
         `:o+++ `ohhhhhhhhyo++os:
           .o:`.syhhhhhhh/.oo++o`
               /osyyyyyyo++ooo+++/
                   ````` +oo+++o\:
                          `oo++.
➜  /tmp
```


### Build image locally:

You can build the image locally if you like and then push to your own repo for testing

```bash
# clone repo
git@github.com:donkeyx/docker_cluster-utils.git
cd docker_cluster-utils

# build and tag
docker build . -t donkeyx/cluster-utils

# push
docker push YOUR_REPO.../cluster-utils:latest
```

### Start container:

Follow the build process above
```bash

$ docker run -e RUNTIME=60 -d --name cluster-utils donkeyx/cluster-utils
1a3b19d75ab9a536ff531935e9da9f9c549d288cb0cab0d6bbdda2249b4ea680

$ docker ps
CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS              PORTS               NAMES
1a3b19d75ab9        donkeyx/cluster-utils   "sh /tmp/sleeper.sh"   3 seconds ago       Up 3 seconds                            cluster-utils

$ docker exec -it cluster-utils zsh
                          ./+o+-       root@1a3b19d75ab9
                  yyyyy- -yyyyyy+      OS: Ubuntu
               ://+//////-yyyyyyo      Kernel: x86_64 Linux 4.19.76-linuxkit
           .++ .:/++++++/-.+sss/`      Uptime: 10h 40m
         .:++o:  /++++++++/:--:/-      Packages: 183
        o:+o+:++.`..```.-/oo+++++/     Shell: zsh 5.4.2
       .:+o:+o/.          `+sssoo+/    CPU: Intel Core i7-6700HQ @ 4x 2.6GHz
  .++/+:+oo+o:`             /sssooo.   GPU:
 /+++//+:`oo+o               /::--:.   RAM: 350MiB / 1989MiB
 \+/+o+++`o++o               ++////.
  .++.o+++oo+:`             /dddhhh.
       .+.o+oo:.          `oddhhhh+
        \+.++o+o``-````.:ohdhhhhh+
         `:o+++ `ohhhhhhhhyo++os:
           .o:`.syhhhhhhh/.oo++o`
               /osyyyyyyo++ooo+++/
                   ````` +oo+++o\:
                          `oo++.
➜  /tmp

```

curling your running container

```bash
❯ http localhost:8080
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 4790
Content-Type: application/json; charset=utf-8
Date: Tue, 02 Apr 2019 08:49:22 GMT
ETag: W/"12b6-OdCM/Gv6+/5YnNIz25ceGper7Zc"
X-Powered-By: Express

{
    "HOME": "/root",
    "HOSTNAME": "377ad6708651",
    "INIT_CWD": "/usr/src/app",
    "LANG": "en_AU.UTF-8",
    "LANGUAGE": "en_AU.UTF-8",
    "LC_ALL": "en_AU.UTF-8",
    "LC_CTYPE": "en_AU.UTF-8",
    "NODE": "/usr/local/bin/node",
    "NODE_VERSION": "11.13.0",
    "PATH": "/usr/local/lib/node_modules/npm/node_modules/npm-lifecycle/node-gyp-bin:/usr/src/app/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "PWD": "/usr/src/app"
}
```
