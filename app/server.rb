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
  ship = Ship.new(3)
  ship2 = Ship.new(3)
  ship3 = Ship.new(4)
  ship4 = Ship.new(5)
  ship5 = Ship.new(5)
  ship6 = Ship.new(3)
  ship7 = Ship.new(3)
  ship8 = Ship.new(4)
  ship9 = Ship.new(5)
  ship10 = Ship.new(5)
  player1 = Player.new()
  player1.board = Board.new(Cell)
  player1.board.place(ship, :A2)
  player1.board.place(ship2, :B7)
  player1.board.place(ship3, :E6)
  player1.board.place(ship4, :F2)
  player1.board.place(ship5, :C4)
  game.add_player(player1)
  player2 = Player.new()
  player2.board = Board.new(Cell)
  game.add_player(player2)
  player2.board.place(ship6, :A1)
  player2.board.place(ship7, :D4)
  player2.board.place(ship8, :F2)
  player2.board.place(ship9, :G4)
  player2.board.place(ship10, :I4)
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

