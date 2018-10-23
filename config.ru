# frozen_string_literal: true

require 'bundler'

Bundler.require

require './app/main.rb'
run Sinatra::Application
