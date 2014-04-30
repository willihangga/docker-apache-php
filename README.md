# Docker Apache PHP

## To Build

``` bash
$ docker build -t eugeneware/docker-apache-php .
```

### To Run

Use [docker volumes](http://docs.docker.io/use/working_with_volumes/) to expose
your web content to the apache web server.

``` bash
# run docker apache php
$ CONTAINER=$(docker run -d -p 80 -p 3306 -v /your/path/to/serve:/var/www/html eugeneware/docker-apache-php)

# get the http port
$ docker port $CONTAINER 80
0.0.0.0:49206
```

### To access the database
``` bash
# get the mysql port
$ docker port $CONTAINER 3306
0.0.0.0:49205
$ mysql -hdockerhost -uroot -P 49205
```
