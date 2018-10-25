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
  redirect '/mastermind'
end

get '/mastermind' do
  game = session[:game]
  input = params['input']

  good_input = game.take_turn(input: input) unless input.nil?
  bad_input = game.bad_input_message if good_input == :bad_input

  guesses = game.guesses
  turns_left = SinatraMind::Game::MAX_GUESSES - game.num_guesses
  key = game.key_to_s
  hints = game.hints

  erb :mastermind, locals: {
    game: game,
    input: input,
    turns_left: turns_left,
    guesses: guesses,
    hints: hints,
    secret_code: game.secret_code,
    key: key,
    bad_input: bad_input
  }
end
