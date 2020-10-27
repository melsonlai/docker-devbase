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

# openvpn for android connection over the internet
RUN apt-get -qq update && \
      apt-get install -yqq openvpn && \
      apt-get clean
      
# pyenv dependencies
RUN apt-get -qq update && \
      apt-get install --no-install-recommends -yqq make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev && \
      apt-get clean
