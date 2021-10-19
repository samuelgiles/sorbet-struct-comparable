#!/usr/bin/env bash
set -e
rm -f Gemfile.lock
bundle install
bundle exec srb tc
METRICS=1 bundle exec rspec spec
