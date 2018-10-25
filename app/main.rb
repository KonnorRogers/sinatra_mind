# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'thin'
require_relative 'sinatra_mind'

enable :sessions

get '/' do
  session[:game] ||= SinatraMind::Game.new
  session[:array] ||= []
  redirect '/mastermind'
end

get '/mastermind' do
  @game = session[:game]

  @input = params['input']
  session[:array] << @input
  @array = session[:array]
  session[:game].take_turn(input: @input) unless @input.nil?

  erb :mastermind
end
