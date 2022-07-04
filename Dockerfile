FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y git curl apt-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev ruby-full libdb-dev postgresql sqlite3 redis-server bundler golang-go imagemagick

RUN go get github.com/mailhog/MailHog
RUN git clone https://github.com/discourse/discourse.git ~/discourse
