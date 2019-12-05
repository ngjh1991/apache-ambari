# Ambari Server

This setup is based on <https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.7.4> (last modified 16 Sep 2019)

# Building and running

```
docker build -t ambari:0.1 .

cd ambari-mysql
docker build -t mysql-server .
docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=root -d --network=my-bridge-network mysql-server
./setup.sh

cd ../ambari-server
docker build -t ambari-server .
docker run -it -p 8080:8080 --network=my-bridge-network --name=ambari-server --hostname=ambari-server ambari-server /bin/bash
```
