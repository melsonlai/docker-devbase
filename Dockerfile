FROM ubuntu:20.04

LABEL maintainer="melsonlai"

ENV TZ="Asia/Taipei"
RUN ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

COPY cont-init.d/* /etc/cont-init.d/
RUN chmod 511 /etc/cont-init.d/01-create-user
COPY services.d/sshagent /etc/services.d/sshagent
RUN chmod 511 /etc/services.d/sshagent/run

RUN apt-get -qq update && \
      apt-get install -yqq \
          sudo bash bash-completion unzip zip tar lsb-core \
          software-properties-common \
          wget curl git openssh-client \
          vim tmux && \
      apt-get clean

ENTRYPOINT [ "/init" ]
CMD [ "/bin/sleep", "infinity" ]

