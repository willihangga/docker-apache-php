# Docker Apache PHP 7.2

### To Build manual way
``` bash
git clone https://github.com/willihangga/docker-apache-php.git
cd docker-apache-php
docker build -t="cyberneo/docker-apache-php" .
CONTAINER=$(docker run -d -p [your custom tcp port]:80 -p [your custom mysql port]:3306 -v /your/path/to/serve:/var/www/html --name yourcontainername cyberneo/docker-apache-php)
docker ps
cd ..
rm -rf docker-apache-php
```

#### Example build
- tcp port: 8080
- mysql port: 33060
- web files location: ~/Documents/localdomain.com
- container name: localdomain.com

``` bash
git clone https://github.com/willihangga/docker-apache-php.git
cd docker-apache-php
docker build -t="cyberneo/docker-apache-php" .
CONTAINER=$(docker run -d -p 8080:80 -p 33060:3306 -v ~/Documents/localdomain.com:/var/www/html --name localdomain.com cyberneo/docker-apache-php)
docker ps
cd ..
rm -rf docker-apache-php
```

### To start/stop your container
``` bash
# start docker apache php
docker start yourcontainername

# stop docker apache php
docker stop yourcontainername
```

### To access your container
``` bash
docker exec -it yourcontainername /bin/bash
```

### To access the database
``` bash
# exec to your container with above command, then run mysql like usual
```
