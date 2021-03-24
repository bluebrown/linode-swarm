# Docker-Prometheus-Grafana Boilerplate

This is boilerplate to work with prometheus in a docker environment

The repo contains 2 different stacks.

1. Profrana is the montitoring stack and consists of
  - prometheous
  - node-exporter
  - cadvisor
  - grafana
2. Nginx serves consists of
  - nginx
  - nginx-exporter

## Setup


Before starting the container, a network named monitoring has to be created. This network is used to expose the metrics pages to prometheus.

```bash
docker network create monitoring # when using swarm create a overlay network with --driver overlay
```

Once the network is created, the stacks can be started.

```bash
cd nginx/ && docker-compose up -d && cd -
cd profana/ && docker-compose up -d && cd -
```