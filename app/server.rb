require 'sinatra/base'

class BattleShipsWeb < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  get('/') do
    erb :index

  end

  get('/enter_name') do
    @player1 = params[:Player1]
    erb :enter_name
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
