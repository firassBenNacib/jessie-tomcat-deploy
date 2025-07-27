
# Jessie Tomcat Deploy

Automates the setup of Tomcat 9 on a legacy Debian Jessie system. Runs Ansible inside a Docker container to simulate a production-like environment and deploy a WAR file with environment-specific JVM settings.


## Table of Contents

* [Overview](#overview)
* [Structure](#structure)
* [Setup](#setup)
* [Environment Configs](#environment-configs)
* [Author](#author)

## Overview

This project builds a `debian:jessie` Docker container with `systemd`, simulating a legacy server setup. It:

* Installs OpenJDK 8 and Tomcat 9
* Configures Tomcat as a `systemd` service
* Deploys a sample WAR file
* Automates everything using Ansible
* Runs basic post-deployment tests

JVM heap size is set automatically:

* `DEV`: `-Xms256m -Xmx256m`
* `PROD`: `-Xms512m -Xmx512m`

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

2. Run the deployment script:

```bash
./scripts/tomcat_deploy.sh DEV
```

Use `PROD` to simulate a production environment.



## Environment Configs

| Variable | Description      | DEV  | PROD |
| -------- | ---------------- | ---- | ---- |
| `ENV`    | Environment name | DEV  | PROD |
| `JVM`    | Max heap size    | 256m | 512m |


## Author

Created and maintained by [Firas Ben Nacib](https://github.com/firassBenNacib) - [bennacibfiras@gmail.com](mailto:bennacibfiras@gmail.com)

