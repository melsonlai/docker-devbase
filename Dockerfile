FROM melsonlai/docker-devbase:base

# tvm
RUN apt-get -qq update && \
      apt-get install -yqq python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev && \
      apt-get clean

# antlr for tvm
RUN apt-get -qq update && \
      apt-get install -yqq openjdk-8-jdk && \
      apt-get clean && \
      ( cd /usr/local/lib && curl -O https://www.antlr.org/download/antlr-4.7.2-complete.jar )

# nodejs for json2nnapi
RUN ( curl -sL https://deb.nodesource.com/setup_13.x | bash - ) && \
      apt-get install -yqq nodejs && \
      apt-get clean

# ndk-dev
RUN apt-get -qq update && \
      apt-get install -yqq bison build-essential curl dos2unix flex git make pbzip2 python python-pip texinfo uuid-runtime zip && \
      apt-get clean


