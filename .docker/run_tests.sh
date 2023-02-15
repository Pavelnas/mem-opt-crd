#!/bin/sh
RAILS_ENV=test rails db:create db:setup
bundle exec rails rspec
