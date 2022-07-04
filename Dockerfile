FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y git curl apt-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev ruby-full libdb-dev postgresql-14 sqlite3 redis-server bundler golang-go imagemagick libpq-dev

EXPOSE 5432
RUN service postgresql start && sudo -u postgres createuser -s root
RUN go install github.com/mailhog/MailHog@latest
RUN git clone https://github.com/discourse/discourse.git ~/discourse

WORKDIR /root/discourse
RUN bundle install

