FROM ubuntu:latest

LABEL maintainer="melsonlai"

ENV TZ="Asia/Taipei"
RUN ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.0.0.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude='./bin' && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin

COPY cont-init.d/* /etc/cont-init.d/
RUN chmod 511 /etc/cont-init.d/01-create-user
COPY services.d/sshagent /etc/services.d/sshagent
RUN chmod 511 /etc/services.d/sshagent/run

RUN apt-get -qq update && \
      apt-get install -yqq \
          sudo bash bash-completion unzip zip tar lsb-core \
          software-properties-common \
          wget curl git openssh-client \
          vim tmux \
          build-essential cmake gdb ninja-build \
          python3 python3-pip python3-dev python3-setuptools && \
      apt-get clean

ENTRYPOINT [ "/init" ]
CMD [ "/bin/sleep", "infinity" ]
