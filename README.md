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
