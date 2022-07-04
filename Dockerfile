FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y git curl apt-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev ruby-full libdb-dev postgresql sqlite3 redis-server bundler golang-go imagemagick libpq-dev

RUN postgres createuser -s "$USER"
RUN go install github.com/mailhog/MailHog@latest
RUN git clone https://github.com/discourse/discourse.git ~/discourse
RUN bundle install --gemfile=/root/discourse/Gemfile

RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
ENV RAILS_ENV="test bundle exec rake db:create db:migrate"
