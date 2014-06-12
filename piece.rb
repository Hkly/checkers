class Piece
  attr_accessor :color, :pos
  def initialize(board, color, pos)
    @board = board
    @color = color
    @position = pos
    @promoted = false
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
  
  def perform_move!(move_arr)
    if move_arr.length > 1
      move_arr.each do |move|
        perform_jump(move)
      end
    else
      perform_slide(move_arr.flatten)
    end
  end
  
  def perform_move(move_arr)
    dupped_board = @board.dup
    piece = dupped_board[@position]
    if move_arr.length > 1
      move_arr.each do |move|
        raise InvalidMoveError unless piece.valid_jump?(move)
      end
    else
      raise InvalidMoveError unless piece.valid_slide?(move_arr.flatten)
    end
    perform_move!(move_arr)
  end
  
  def perform_slide(target)
    if valid_slide?(target)
      @board[@position] = nil
      @position = target
      @board[target] = self
    end
  end
  
  def perform_jump(target)
    if valid_jump?(target)
      @board[@position] = nil
      @board[jumped_tile(target)] = nil
      @position = target
      @board[target] = self
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
    jumps = []
    move_deltas.each do |delta|
        x = @position.first + (delta.first * 2)
        y = @position.last + (delta.last * 2)
        jumps << [x, y] if (0...8).include?(x) && (0...8).include?(y)
    end
    jumps
  end
  
  def jumped_tile(target)
    jumped_x = (@position.first + target.first) / 2
    jumped_y = (@position.last + target.last) / 2
    [jumped_x, jumped_y]
  end
  
  def valid_slide?(target)
    possible_slides.include?(target) && @board[target].nil?
  end
  
  def valid_jump?(target)
    if possible_jumps.include?(target)
      @board.capturable?(jumped_tile(target), @color) && @board[target].nil?
    end
  end
  
  def inspect
    return @color.to_s
  end
  
  def render
    if @promoted
      return " \u2654 "
    else
      symbol = " \u25CE " # " \u25CE " " \u274D "
      return symbol.colorize(:color => @color, :background => :black)
  end
end





