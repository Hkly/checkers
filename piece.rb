class Piece
  attr_accessor :color, :pos
  def initialize(board, color, pos)
    @board = board
    @color = color
    @position = pos
    @promoted = false
  end
  
  def inspect
    return color.to_s
  end
  
  def move_deltas
    if @promoted
      return [[1, 1], [1 - 1], [-1, 1], [-1, -1]]
    else
    # Red moves "down" the board
      dy = @color == :red ? 1 : -1
      return [[dy, -1], [dy, 1]]
    end
  end
  
  def perform_slide(target)
    @position = target if valid_slide?(target)
  end
  
  def perform_jump(target)
    if valid_jump?(target)
      @position = target 
      # remove jumped over piece
    end
  end
  
  def maybe_promote
    back_row = @color == :red ? 7 : 0
    @promoted = true if @position.first == back_row
  end
  
  def possible_slides
    [].tap do |moves|
      move_deltas.each do |delta|
        x = @position.first + delta.first
        y = @position.last + delta.last
        moves << [x, y] if (0...8).include?(x) && (0...8).include?(y)
      end
    end
  end
  
  def possible_jumps
    paths = []
    move_deltas.each do |delta|
      path = []
      (1..2).each do |n|
        x = @position.first + (delta.first * n)
        y = @position.last + (delta.last * n)
        path << [x, y] if (0...8).include?(x) && (0...8).include?(y)
      end
      paths << path
    end
    paths = paths.select do |path| 
      path.length == 2 && @board.capturable?(path.first, @color)
    end
    paths.map {|path| path.last}
  end
  
  def valid_slide?(target)
    possible_slides.include?(target) && @board[target].nil?
  end
  
  def valid_jump?(target)
    possible_jumps.include?(target) && @board[target].nil? 
  end
end





