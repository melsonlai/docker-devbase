FROM melsonlai/docker-devbase:llvm

RUN apt-get update -qq && \
      apt-get install -yqq byacc flex && \
      apt-get clean
