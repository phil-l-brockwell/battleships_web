require 'sinatra/base'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/cell'



class BattleShipsWeb < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  game = Game.new


  get('/') do
    erb :index
  end

  get('/enter_name') do
    erb :enter_name
  end

  post('/new_game') do
    player = Player.new()
    player.name = params[:user_name]
    player.board = Board.new(Cell)
    puts player.board.inspect
    game.add_player(player)
    computer = Player.new()
    computer.name = "computer"
    computer.board = Board.new(Cell)
    puts computer.board.inspect
    game.add_player(computer)
    @player = game.player1
    puts game.inspect
    erb :new_game
  end

  get '/shoot' do
    puts game.inspect
    game.shoots(params[:cell])
    @player = game.player1
    erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
