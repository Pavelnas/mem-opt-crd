FROM ruby:3.0.0

RUN apt-get update &&  apt-get install -y \
  build-essential \
  netcat \
  git-core \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v '= 2.2.3'
RUN bundle install --jobs 20 --retry 5

COPY ./.docker/start.sh /bin/start.sh

RUN chmod +x /bin/start.sh

COPY . .