FROM ruby:2.7.6-bullseye

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
#RUN apt-get install -y wget lsb-release git curl apt-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libgdbm6 checkinstall ruby-full libdb-dev postgresql sqlite3 bundler golang-go imagemagick libpq-dev
RUN apt-get install -y wget lsb-release git curl apt-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libgdbm6 checkinstall libdb-dev postgresql sqlite3 bundler golang-go imagemagick libpq-dev curl
RUN gem update bundler

EXPOSE 5432
EXPOSE 6379

RUN wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz && tar -zxf openssl-1.1.1n.tar.gz
RUN pwd
WORKDIR /openssl-1.1.1n
RUN ls
RUN ./config --prefix=/opt/openssl-1.1.1n --openssldir=/opt/openssl-1.1.1n shared zlib
RUN make && make install
RUN rm -rf /opt/openssl-1.1.1n/certs && ln -s /etc/ssl/certs /opt/openssl-1.1.1n

RUN curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
RUN apt-get -y update && apt-get -y install redis

RUN service postgresql start && sudo -u postgres createuser -s root
RUN go get github.com/mailhog/MailHog
RUN git clone https://github.com/mkmrgn/discourse.git ~/discourse

WORKDIR /root/discourse
RUN bundle install --verbose

