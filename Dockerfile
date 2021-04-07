FROM ubuntu:20.04

LABEL maintainer="melsonlai"

ENV TZ="Asia/Taipei"
RUN ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

COPY cont-init.d/* /etc/cont-init.d/
RUN chmod 511 /etc/cont-init.d/01-create-user
COPY services.d/sshd /etc/services.d/sshd
RUN chmod 511 /etc/services.d/sshd/run

RUN apt-get -qq update && \
      apt-get install -yqq \
          sudo bash bash-completion unzip zip tar lsb-core \
          software-properties-common \
          wget curl git openssh-client \
          vim tmux && \
      apt-get clean

RUN apt-get -qq update && \
      apt-get install -yqq openssh-server && \
      apt-get clean && \
      mkdir /var/run/sshd && \
      sed -i 's/^\(# *\)\?PermitRootLogin [A-Za-z0-9\-]\+$/PermitRootLogin no/g' /etc/ssh/sshd_config && \
      sed -i 's/^\(# *\)\?PubkeyAuthentication [A-Za-z0-9\-]\+$/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
      sed -i 's/^\(# *\)\?PasswordAuthentication [A-Za-z0-9\-]\+$/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
      sed -i 's/^\(# *\)\?PermitEmptyPasswords [A-Za-z0-9\-]\+$/PermitEmptyPasswords no/g' /etc/ssh/sshd_config && \
      sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENTRYPOINT [ "/init" ]
CMD [ "/bin/sleep", "infinity" ]

