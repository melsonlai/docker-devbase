FROM melsonlai/docker-devbase:llvm

# tvm
RUN apt-get -qq update && \
      apt-get install -yqq python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev && \
      apt-get clean

# antlr for tvm
RUN apt-get -qq update && \
      apt-get install -yqq openjdk-8-jdk && \
      apt-get clean && \
      ( cd /usr/local/lib && curl -O https://www.antlr.org/download/antlr-4.7.2-complete.jar )

# onnx deps
RUN apt-get -qq update && \
      apt-get install -yqq protobuf-compiler libprotoc-dev && \
      apt-get clean

