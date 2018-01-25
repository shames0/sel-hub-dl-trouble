FROM alpine:latest
VOLUME ["/var/ruby"]

RUN apk update
## install ruby
RUN apk add make ruby bzip2 ca-certificates libffi-dev libressl-dev procps yaml-dev zlib-dev ruby-dev build-base

# set up ruby
WORKDIR /var/ruby
COPY ["./.gemrc", "/root/.gemrc"]
COPY ["./Gemfile", "/var/ruby/Gemfile"]
RUN gem install bundle \
    && bundle install
