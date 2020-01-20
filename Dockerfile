FROM ubuntu:latest

LABEL maintainer="melsonlai"
ENV PUID="1000" PGID="1000" PUSERNAME="dev"
COPY init.sh /init.sh
RUN chmod +x /init.sh

RUN apt-get -qq update && \
      apt-get install -yqq \
          sudo bash bash-completion unzip tar lsb-core \
          software-properties-common \
          wget curl git openssh-client \
          vim tmux \
          build-essential cmake gdb \
          python3 python3-pip python3-dev python3-setuptools && \
      ( wget -O- https://apt.llvm.org/llvm.sh | bash ) && \
      apt-get clean

CMD [ "/init.sh", "/bin/sleep", "infinity" ]
