#!/usr/bin/env bash
set -e

export RAILS_ENV=${RAILS_ENV:-production}
export RAILS_LOG_TO_STDOUT=1
export RAILS_LOG_LEVEL=debug
export DISABLE_BOOTSNAP=1  # 例外を見やすく

echo "== Check required envs =="
ruby -e 'print "DATABASE_URL: "; puts(ENV["DATABASE_URL"] ? "set" : "MISSING")'
ruby -e 'print "RAILS_MASTER_KEY: "; puts(ENV["RAILS_MASTER_KEY"] ? "set" : "MISSING")'

echo "== DB prepare =="
bundle exec rails db:prepare

echo "== Try boot once (runner) =="
# ここで Rails が起動できなければ、原因が赤字で出ます
bundle exec rails runner -e production "puts :BOOT_OK"

echo "== Precompile assets =="
bundle exec rails assets:precompile

echo "== Start server =="
exec bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
