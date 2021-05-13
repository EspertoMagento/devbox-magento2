# **Magento 2.4 on Centos 7**

Software installed on Docker Image:

CENTOS,
PHP 7.4, 
APACHE 2.4.6, 
COMPOSER 2.0, 
GIT 1.8

In your local directory run:

```shell
git clone https://github.com/EspertoMagento/devbox-magento2.git
```

In the root create Magento project:

```shell
COMPOSER_MEMORY_LIMIT=-1 composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2
```


Turn up the machine. Run:

```shell
docker-compose up -d
```


Run this command to install Magento:

```shell
docker exec -it <container_name> install-magento
```

Run this command to install sample-data:

```shell
docker exec -it <container_name> install-sampledata
```

Add in your local /etc/hosts

```shell
127.0.0.1 local.magento
```



Go to https://local.magento



## Finish!