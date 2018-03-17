# Docker Apache PHP

## To Build manual way
``` bash
git clone https://github.com/willihangga/docker-apache-php.git
cd docker-apache-php
sudo docker build -t="eugeneware/docker-apache-php" .
CONTAINER=$(docker run -d -p 8080:80 -p 33060:3306 -v ~/localsite.com/www:/var/www/html --name localsite.com eugeneware/docker-apache-php)
sudo docker ps

cd ..
rm -rf docker-apache-php
```

### To Run

Use [docker volumes](http://docs.docker.io/use/working_with_volumes/) to expose
your web content to the apache web server.

``` bash
# run docker apache php
$ CONTAINER=$(docker run -d -p 8080:80 -p 33060:3306 -v /your/path/to/serve:/var/www/html eugeneware/docker-apache-php)

# get the http port
# $ docker port $CONTAINER 80
# 0.0.0.0:49206
```

### To access your container
``` bash
docker exec -it localsite.com /bin/bash
```

### To access the database
``` bash
# exec to your container with above command, then run mysql like usual
```
