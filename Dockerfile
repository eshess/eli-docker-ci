FROM centos:centos6

MAINTAINER eli@elihess.com

# Enable EPEL for Node.js
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install Node...
RUN yum install -y npm
RUN npm config set strict-ssl false

# Copy app to /src
COPY . /src

# Install app and dependencies into /src
RUN cd /src; npm install

EXPOSE 8080
CMD sed -i "s/Cluster/Cluster $MY_NODE_NAME $MY_POD_NAME/g" /src/views/home.jade && cd /src && node ./app.js
