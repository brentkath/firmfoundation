#!/usr/bin/env bash
# Exit on error
set -o errexit
 
bundle install
bundle exec rake assets:precompile
bundle exec rake db:migrate 