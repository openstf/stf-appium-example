# https://github.com/vbanthia/docker-appium/tree/master/appium-ruby/onbuild/Dockerfile
FROM vbanthia/appium-ruby:1.4.16

RUN bundle config --global frozen 1 \
  && mkdir -p /usr/src \

WORKDIR /usr/src

COPY Gemfile /usr/src/
COPY Gemfile.lock /usr/src/

RUN bundle install \
  && npm install

# Run following script on docker run
ENTRYPOINT ["./scripts/run_integration_test.sh"]
