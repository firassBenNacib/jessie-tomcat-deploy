# Jessie Tomcat Deploy

Automate the setup of Tomcat 9 on a legacy Debian Jessie system. This project uses Ansible inside a Docker container to simulate a production-like environment and deploy a WAR file.

## Overview

This project builds a Docker container running `debian:jessie` with `systemd`, simulating a legacy server.

Inside the container:

* Installs OpenJDK 8 and Tomcat 9
* Configures Tomcat as a `systemd` service
* Deploys a sample WAR file
* Uses Ansible for full automation
* Runs post-deployment tests

JVM heap size is automatically set based on the environment:

* `DEV`: `-Xms256m -Xmx256m`
* `PROD`: `-Xms512m -Xmx512m`

## Table of Contents

* [Structure](#structure)
* [Setup](#setup)
* [Environment Configs](#environment-configs)
* [Author](#author)




## Structure

```
jessie-tomcat-deploy/
├── Dockerfile
├── ansible-playbook/
│   └── tomcat_deploy.yml
├── scripts/
│   ├── fix-dbus.sh
│   ├── tomcat_deploy.sh
│   └── tomcat_test.sh
└── war/
    └── sample.war
```


## Setup

1. Clone the repository:

```bash
git clone https://github.com/firassBenNacib/jessie-tomcat-deploy.git
cd jessie-tomcat-deploy
```

2. Run the deployment:

```bash
./scripts/tomcat_deploy.sh DEV
```

Use `PROD` to simulate a production-like setup.



## Environment Configs

| Variable | Description      | DEV  | PROD |
| -------- | ---------------- | ---- | ---- |
| `ENV`    | Environment name | DEV  | PROD |
| `JVM`    | Max heap size    | 256m | 512m |



## Author

Created and maintained by [Firas Ben Nacib](https://github.com/firassBenNacib) - bennacibfiras@gmail.com
