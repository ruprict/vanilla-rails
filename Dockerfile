FROM alpine:3.4
MAINTAINER Glenn Goodrich <glenn.goodrich@skookum.com>

ENV BUILD_PACKAGES ruby build-dependencies openssl-dev libxml2-dev libxslt-dev libgcrypt libffi-dev git ncurses tzdata postgresql-client
ENV RUBY_PACKAGES ruby ruby-irb ruby-json ruby-rake ruby-io-console ruby-bundler ruby-bigdecimal nodejs

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

# Update the package manager
RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs libffi-dev

EXPOSE 3000

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    postgresql-dev libc-dev linux-headers
RUN gem install bundler --no-rdoc --no-ri
RUN bundle install --jobs 20 --retry 5 --without development test

RUN npm install -g -s --no-progress yarn
RUN apk del build-dependencies

COPY . /app
RUN rails assets:precompile

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
