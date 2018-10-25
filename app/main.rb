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

  message = game.take_turn(input: input)
  message = game.bad_input_message if message == :bad_input
  message = game.win_message if message == :win
  message = game.lose_message if message == :lose

  guesses = game.guesses_to_s
  turns_left = SinatraMind::Game::MAX_GUESSES - game.num_guesses
  key = game.key_to_s
  hints = game.hints_to_s

  erb :mastermind, locals: {
    game: game,
    message: message,
    input: input,
    turns_left: turns_left,
    guesses: guesses,
    hints: hints,
    secret_code: game.secret_code,
    key: key
  }
end
