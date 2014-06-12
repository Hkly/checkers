class Board
  attr_accessor :grid
  
  def self.make_starting_board
    board = Board.new
    board.grid.each do |space|
      
    end
  end
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end
  
  def place_piece(color, pos)
    piece = Piece.new(self, color, pos)
    self[pos] = piece
  end
  
  def perform_moves(move_arr)
    
  end
  
  def capturable?(position, curr_color)
    self[position].color != curr_color
  end
  
  def inspect
    return @grid.each {|r| p r.to_s}
  end
  
  def [](pos)
    x = pos[0]
    y = pos[1]
    @grid[x][y]
  end
  
  def []=(pos, value)
    x = pos[0]
    y = pos[1]
    @grid[x][y] = value
  end
end