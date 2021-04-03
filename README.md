# Setup

1. create linode account and api token
2. create ssh key pair
    - ssh-keygen
    - ssh-agent bash
    - ssh-add <my-private-key>
3. create hashed and salted pw
4. provision with tf
5. run playbook


## Snippets

```
openssl passwd -salt superSalt -1 superPWD
```

```
tf output -json | jq --raw-output '.private_ip.value'
```


```
docker network create --subnet 172.18.0.0/16 --opt com.docker.network.bridge.name=docker_gwbridge --opt com.docker.network.bridge.enable_icc=false --opt com.docker.network.bridge.enable_ip_masquerade=true docker_gwbridge
```

```
sudo iptables -I INPUT -s 192.168.131.162 -p tcp -m multiport --dports 7946,2377 -j ACCEPT
sudo iptables -I INPUT -s 192.168.131.162 -p udp -m multiport --dports 7946,4789 -j ACCEPT
```
For docker metrics page to work docker0 must be accepted in the input chain