#!/usr/bin/env bash
set -e

# 環境を production に固定
export RAILS_ENV=${RAILS_ENV:-production}

# DB をマイグレーション（失敗したらセットアップ）
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

# アセットをプリコンパイル
bundle exec rails assets:precompile

# Railsサーバーを起動（Render が指定する $PORT を利用）
exec bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}