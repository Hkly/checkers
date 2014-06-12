require 'colorize'
require_relative 'piece'
require_relative 'board'

class Game
  
  def self.start_new_game

  end
  
  def initialize
    @board = Board.make_starting_board
    @player1 = HumanPlayer.new(:red)
    @player2 = HumanPlayer.new(:black)
  end
  
  def play
    until won?
      
    end
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