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
  ship = Ship.new(1)
  ship2 = Ship.new(1)
  ship3 = Ship.new(1)
  ship4 = Ship.new(1)
  player1 = Player.new()
  player1.board = Board.new(Cell)
  player1.board.place(ship, :A7)
  player1.board.place(ship2, :B7)
  game.add_player(player1)
  player2 = Player.new()
  player2.board = Board.new(Cell)
  game.add_player(player2)
  player2.board.place(ship3, :A1)
  player2.board.place(ship4, :B1)

  get('/') do
    erb :index
  end

  get('/enter_name') do
    erb :enter_name
  end

  post('/enter_second_name') do
    player1.name = params[:player1_name]
    erb :enter_second_name
  end

  post('/new_game') do
    player2.name = params[:player2_name]
    @current_player = game.current_player
    game.current_player == player1 ? @opponent = game.player2 : @opponent = game.player1
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
    @current_player = game.current_player
    game.current_player == player1 ? @opponent = game.player2 : @opponent = game.player1
      erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

