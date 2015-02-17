require 'sinatra/base'

class BattleShipsWeb < Sinatra::Base
  get '/' do
    'Hello BattleShipsWeb!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
