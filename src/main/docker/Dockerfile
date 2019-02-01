# VERSION 1.0.0
# AUTHOR: Exadatum
# DESCRIPTION: Cloudera hue with Adls Fuse


# Build
# docker build -t  adls_fuse:1.0.0 .

# Create container
# docker run -it -d -v  /home/exa00015/fuse/conf/:/etc/hadoop/conf/  -e ABFS_URI=abfs://sprk-itds-dev-wus-2019-01-23t04-24-36-227z@absitdsdevwus001.dfs.core.windows.net --privileged adls_fuse:1.0.0

FROM ubuntu:16.04
LABEL maintainer="exadatum_"


# Arguments and Environment Variables
ARG CDH_REPO_URI=https://archive.cloudera.com/cdh6/6.1.0/ubuntu1604/apt
ARG CDH_RELEASE_NAME=xenial-cdh6.1.0
ENV MOUNT_POINT=/root/mount
ENV ABFS_URI=


# Setting up required packages on ubuntu
RUN apt-get update -yqq \
 && apt-get install apt-utils -y \
 && apt-get install software-properties-common -yqq \
 && add-apt-repository -y ppa:webupd8team/java \
 && apt-get update -y \
 && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && apt-get install -y oracle-java8-installer \
 && apt-get install apt-transport-https -yqq \
 && apt-get install module-init-tools -yqq \
 && apt-get install module-assistant -yqq \
 && apt-get install --reinstall linux-image-`uname -r` -yqq \
 && apt-get install wget -yqq


# Configure cloudera repository
RUN echo "deb ${CDH_REPO_URI} ${CDH_RELEASE_NAME} contrib" >> /etc/apt/sources.list.d/cloudera.list \
 && wget ${CDH_REPO_URI}/archive.key \
 && apt-key add archive.key \
 && apt-get update -yqq \
 && apt-get install hadoop hadoop-hdfs libhdfs0 openssl hadoop-hdfs-fuse -yqq


# Installing Required modules for Hue
RUN apt-get install --fix-missing -q -y \
  git \
  ant \
  gcc \
  g++ \
  libkrb5-dev \
  libmysqlclient-dev \
  libmysql-java \
  libssl-dev \
  libsasl2-dev \
  libsasl2-modules-gssapi-mit \
  libsqlite3-dev \
  libtidy-0.99-0 \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  make \
  maven \
  libldap2-dev \
  python-dev \
  python-setuptools \
  libgmp3-dev \
  libz-dev

RUN git clone https://github.com/cloudera/hue.git
WORKDIR hue
RUN make apps
EXPOSE 8888
VOLUME /hue/desktop/

#CMD ["build/env/bin/hue", "runserver_plus", "0.0.0.0:8888"]

CMD ["/bin/bash","-c","mkdir -p ${MOUNT_POINT} && /usr/bin/hadoop-fuse-dfs ${ABFS_URI} ${MOUNT_POINT} && build/env/bin/hue runserver_plus 0.0.0.0:8888"]
