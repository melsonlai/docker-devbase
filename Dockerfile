FROM melsonlai/docker-devbase:base

RUN apt-get update -qq && \
      apt-get install -yqq build-essential byacc flex && \
      apt-get clean

