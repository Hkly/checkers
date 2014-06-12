class Board
  attr_accessor :grid
  
  def self.make_starting_board
    board = Board.new
    (0..2).each do |row|
      (0..7).each do |col|
        if row.even? == col.even?
          board.place_piece(:red, [row, col])
        end
      end 
    end
    
    (5..7).each do |row|
      (0..7).each do |col|
        if row.even? == col.even?
          board.place_piece(:blk, [row, col])
        end
      end 
    end
    
    board
  end
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end
  
  def place_piece(color, pos)
    piece = Piece.new(self, color, pos)
    self[pos] = piece
  end
  
  def dup
    dupped_board = Board.new
    @grid.each_with_index do |row, r_index|
      row.each_with_index do |tile, c_index|
        unless tile.nil?
          pos = [r_index, c_index]
          color = tile.color
          dupped_board.place_piece(color, pos)
      end
    end
    dupped_board
  end
  
  def capturable?(position, curr_color)
    self[position].color != curr_color
  end
  
  def inspect
    return @grid.each {|r| p r.to_s}
  end
  
  def render
    color = :black
    puts "   0  1  2  3  4  5  6  7"
    @grid.each_with_index do |row, i|
      print "#{i} "
      row.each do |tile|
        if tile.nil?
          print "   ".colorize(:background => color)
        else
          print tile.render
        end
        color = toggle_color(color)
      end
      color = toggle_color(color)
      puts
    end
  end
  
  def toggle_color(color)
    color == :red ? :black : :red
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