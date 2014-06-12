require 'colorize'
require_relative 'piece'
require_relative 'board'
require_relative 'player'

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
    until won?
      @board.render
      piece = @board[player.get_piece]
      # raise "That's not your piece!" unless player.color == piece.color
      target = [player.get_target]
      piece.perform_move(target)
      player = toggle_player(player)
    end
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
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end