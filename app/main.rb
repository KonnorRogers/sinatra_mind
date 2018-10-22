# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'thin'
require_relative 'sinatra_mind'

enable :sessions

game = SinatraMind::Game.new

get '/' do
  redirect '/mastermind'
end

get '/mastermind' do
  session[:game] ||= game
  session[:array] ||= []
  @game = session[:game]

  @input = params['input']
  session[:array] << @input
  session[:game].take_turn(input: @input) unless @input.nil?

  erb :mastermind, locals: {
    game: @game,
    input: @input,
    array: session[:array],
    guesses: @game.board.guess_array
  }
end
