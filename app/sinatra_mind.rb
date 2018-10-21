# frozen_string_literal: true

lib_path = File.dirname(File.expand_path(__FILE__))
Dir[lib_path + '/lib/**/*.rb'].each { |file| require file }

require 'sinatra'
require 'sinatra/reloader' if development?

module SinatraMind
  # Your code here
end

enable :sessions

game = Game.new

get '/' do
  @session = session
  erb :index, locals: { game: game }
end
