require 'sinatra'
require 'sinatra/reloader' if development?
require 'thin'
require_relative 'sinatra_mind'

enable :sessions

get '/' do
  redirect '/mastermind' unless session.nil?
end

get '/mastermind' do
  @session = session
  @session['game'] ||= SinatraMind::Game.new
  @game = @session['game']

  @input = params['input']
  @game.take_turn(input: @input)
  @guesses = @game.board.board[:guesses]
  @hints = @game.board.board[:hints]

  erb :mastermind, local: { game: @game, guesses: @guesses, hints: @hints }
end
