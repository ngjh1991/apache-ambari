FROM ambari:0.1

RUN yum -y install apache-ambari-2.7.4-src/ambari-server/target/rpm/ambari-server/RPMS/x86_64/ambari-server-2.7.4.0-0.x86_64.rpm

# jdbc connector should be in /usr/share/java/mysql-connector-java.jar after the below step
RUN wget https://dev.mysql.com/get/mysql-connector-java-8.0.18-1.el7.noarch.rpm && \
    rpm --install mysql-connector-java-8.0.18-1.el7.noarch.rpm

# To fix ambari-web bug where cluster wizard is stuck at step 1
COPY app.js /usr/lib/ambari-server/web/javascripts/

# ambari-server setup
# ambari-server start
