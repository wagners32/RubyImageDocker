FROM alpine:3.12.0

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base freetds-dev mariadb-dev tzdata
ENV RUBY_PACKAGES ruby ruby-json ruby-bigdecimal ruby-io-console ruby-bundler

# Update and install all of the required packages. At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/

RUN bundle install

ADD . $APP_HOME

EXPOSE 3000

CMD ["comand", "start", "app"]