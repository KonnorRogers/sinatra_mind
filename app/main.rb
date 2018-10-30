# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'thin'
require_relative 'sinatra_mind'

enable :sessions

DIR_PATH = File.dirname(__FILE__)
set :views, DIR_PATH + '/views'
set :public_folder, DIR_PATH + '/public'

get '/' do
  redirect '/mastermind'
end

get '/mastermind' do
  session[:game] ||= SinatraMind::Game.new
  game = session[:game]
  # resets on next get request
  game.reset if game.win? || game.loss?

  input = params['input']

  feedback = game.take_turn(input: input)
  message = game.bad_input_message if feedback == :bad_input

  guesses = game.guesses_to_s.reverse
  turns_left = SinatraMind::Game::MAX_GUESSES - game.num_guesses
  key = game.key_to_s
  h_key = game.h_key_to_s
  hints = game.hints_to_s.reverse
  # used to display reset message, must be checked after the turn is taken.
  reset = true if game.win? || game.loss?

  erb :mastermind, locals: {
    game: game,
    message: message,
    input: input,
    turns_left: turns_left,
    guesses: guesses,
    hints: hints,
    secret_code: game.secret_code,
    key: key,
    reset: reset,
    h_key: h_key
  }
end
