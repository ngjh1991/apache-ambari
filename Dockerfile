FROM centos:7

RUN yum -y update && yum clean all
RUN yum -y install wget && yum clean all

RUN yum -y install java-1.8.0-openjdk-devel && yum clean all
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

RUN cd /usr/local/src && \
    wget https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
    tar xf apache-maven-3.6.3-bin.tar.gz && \
    mv apache-maven-3.6.3 apache-maven/
ENV M2_HOME=/usr/local/src/apache-maven
ENV PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH

RUN wget http://www.apache.org/dist/ambari/ambari-2.7.4/apache-ambari-2.7.4-src.tar.gz && \
    tar xfvz apache-ambari-2.7.4-src.tar.gz && \
    cd apache-ambari-2.7.4-src && \
    mvn versions:set -DnewVersion=2.7.4.0.0 && \
    pushd ambari-metrics && \
    mvn versions:set -DnewVersion=2.7.4.0.0 && \
    popd

# Compilers and related tools:
RUN yum groupinstall -y "development tools" && yum clean all
# Libraries needed during compilation to enable all features of Python:
RUN yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel && yum clean all
RUN wget https://www.python.org/ftp/python/2.6.7/Python-2.6.7.tgz && \
    tar xf Python-2.6.7.tgz && \
    cd Python-2.6.7 && \
    ./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" && \
    make && make altinstall && \
    strip /usr/local/lib/libpython2.6.so.1.0

RUN wget https://bootstrap.pypa.io/2.6/get-pip.py && \
    python2.6 get-pip.py && \
    pip2.6 install virtualenv && \
    virtualenv py26

RUN yum -y install python-devel && yum clean all
RUN source py26/bin/activate && \
    cd apache-ambari-2.7.4-src && \
    mvn -B clean install rpm:rpm -DnewVersion=2.7.4.0.0 -DbuildNumber=b730f30585dd67c10d3b841317100f17d4b2c5f1 -DskipTests -Dpython.ver="python >= 2.6" && \
    deactivate
