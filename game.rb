require 'colorize'
require_relative 'piece'
require_relative 'board'
require_relative 'player'
require_relative 'errors'

class Game
  attr_accessor :board, :player1, :player2
  def self.start_new_game

  end
  
  def initialize
    @board = Board.make_starting_board
    @player1 = HumanPlayer.new(:red)
    @player2 = HumanPlayer.new(:black)
  end
  
  def play
    player = @player1
    until won? || draw?
      begin
        puts "#{player.color.capitalize}'s turn."
        @board.render
        piece = @board[player.get_piece]
        raise InvalidPieceError if piece.nil? || piece.color != player.color 
        target = player.get_target
        piece.perform_move(target)
      rescue InvalidPieceError => e
        puts "Invalid Piece Selection! Try again."
        retry
      rescue InvalidMoveError => e
        puts "Invalid Move! Try again."
        retry
      rescue
        puts "What was that again?"
        retry
      end
      player = toggle_player(player)
    end
    puts won? ? "#{winner.capitalize} wins!" : "Draw."
  end
  
  def toggle_player(player)
    player == @player1 ? @player2 : @player1
  end
  
  def won?
    !winner.nil?
  end
  
  def winner
    flat_board = @board.grid.flatten.compact
    return :red if flat_board.all? {|t| t.color == :red }
    return :black if flat_board.all? {|t| t.color == :black }
  end
  
  def draw?
    
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end


test = Board.make_starting_board
test.place_piece(:red, [4,2])
test[[1,5]] = nil
test[[5,1]].perform_move([[3,3],[1,5]])