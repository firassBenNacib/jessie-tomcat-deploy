# Jessie Tomcat Deploy

Automate the setup of a Tomcat 9 service on a legacy Debian Jessie system, using Ansible inside a Docker container. This project builds a simulated environment for testing WAR deployments under controlled JVM heap settings.



## Table of Contents

* [Overview](#overview)
* [Structure](#structure)
* [Setup](#setup)
* [Features](#features)
* [Environment Configs](#environment-configs)
* [Author](#author)



## Overview

This project builds a Docker container running Debian Jessie with `systemd`, simulating a legacy production machine. Inside it:

* Installs Java 8 and Tomcat 9
* Deploys a sample WAR
* Runs tests to verify deployment
* Uses Ansible for full provisioning

Memory allocation is based on the environment:

* `DEV`: 256m heap
* `PROD`: 512m heap



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


## Features

* Full automation with Ansible
* Simulated legacy Debian Jessie container
* Systemd-managed Tomcat 9 service
* WAR deployment and service validation
* Environment-based JVM configuration


## Environment Configs

| Variable | Description      | DEV  | PROD |
| -------- | ---------------- | ---- | ---- |
| `ENV`    | Environment name | DEV  | PROD |
| `JVM`    | Max heap size    | 256m | 512m |



## Author

Created and maintained by [Firas Ben Nacib](https://github.com/firassBenNacib) - bennacibfiras@gmail.com
