require 'sinatra/base'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/cell'
require_relative '../lib/ship'



class BattleShipsWeb < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }
  set :public_folder, Proc.new { File.join(root, '..', "public") }

  enable :sessions

  game = Game.new

  get('/') do
    erb :index
  end

  get('/enter_name') do
    erb :enter_name
  end

  post('/new_game') do
    ship = Ship.new(1)
    ship2 = Ship.new(1)
    ship3 = Ship.new(1)
    ship4 = Ship.new(1)
    player = Player.new()
    player.name = params[:user_name]
    player.board = Board.new(Cell)
    player.board.place(ship, :A7)
    player.board.place(ship2, :B7)
    game.add_player(player)
    computer = Player.new()
    computer.name = "computer"
    computer.board = Board.new(Cell)
    game.add_player(computer)
    computer.board.place(ship3, :A1)
    computer.board.place(ship4, :B1)
    @player = game.current_player
    erb :new_game
  end

  get '/shoot' do
    begin
      game.shoots(params[:cell].to_sym)
    rescue GameOverError => e
      @message = e.message
    rescue DoubleHitError => e
      @message = e.message
    end
      @player = game.current_player
      erb :new_game
  end

  get './winnner' do

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

