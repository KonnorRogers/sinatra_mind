require 'sinatra'
require 'sinatra/reloader' if development?
require 'sintra_mind'


enable :sessions

get '/' do
  @session = session
  @session["game"] = Game.new
  erb :index, locals: { game: game }
end
