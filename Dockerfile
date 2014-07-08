FROM centos
MAINTAINER Craig Wickesser <codecraig@gmail.com>

# install vim
RUN yum -y install vim tar

# install java
RUN yum -y install java-1.7.0-openjdk-devel.x86_64
RUN mkdir -p /opt/java && ln -s /usr/lib/jvm/java-1.7.0 /opt/java/latest
ENV JAVA_HOME /opt/java/latest
ENV PATH $PATH:$JAVA_HOME/bin

# install sshd
RUN yum install -y openssh-server openssh-clients passwd
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

#
# nginx
###########################
ADD files/etc/yum.repos.d/nginx.repo /etc/yum.repos.d/
RUN yum -y install nginx
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN rm -v /etc/nginx/nginx.conf
#ADD files/etc/nginx/nginx.conf /etc/nginx/
#ADD files/etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default
ADD files/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD files/usr/bin/start-server.sh /usr/bin/start-server.sh
RUN chmod +x /usr/bin/start-server.sh
RUN mkdir -p /data/www
ADD files/index.html /data/www/index.html

WORKDIR /

EXPOSE 80

#
# glu
############################
ADD files/org.linkedin.glu.packaging-all-5.5.1.tgz /data
WORKDIR /data/org.linkedin.glu.packaging-all-5.5.1/bin
RUN ./tutorial.sh start

# expose ports for Glu (agent, console, webapp1, webapp2, webapp3, zookeeper)
EXPOSE 12906 8080 9000 9001 9003 2181

WORKDIR /
#ENTRYPOINT /usr/bin/start-server.sh
