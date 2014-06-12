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
  
  # TA: should raise errors if invalid move sequence.
  def perform_move!(move_arr)
    # TA: we should be throwing an error if any move in the seq fails.
    if move_arr.length > 1
      move_arr.each do |move|
        perform_jump(move)
      end
    else
      move = move_arr[0]#.flatten
      # TA: perform_slide will raise error if this is a valid jump.
      perform_slide(move) || perform_jump(move)
    end
  end
  
  # TA:
  # 1. perform_moves!
  # 2. valid_move_sequence? Should catch any errors, and return false if needed.
  # 3. perform_move => valid_move_sequence? and then maybe perform_moves!
  
  def perform_move(move_arr)
    dupped_board = @board.dup
    piece = dupped_board[@position]
    new_start = @position
    if move_arr.length > 1
      move_arr.each do |move|
        puts "Invalid move" unless piece.valid_jump?(move)
        perform_jump(move)
      end
    else
      move = move_arr.flatten
      unless piece.valid_slide?(move) || piece.valid_jump?(move)
        puts "Invalid move"
      end
    end
    perform_move!(move_arr)
  end
  
  def valid_move_sequence?moves_arr)
    perform_move(moves_arr)
  end
  
  # TA:
  # These methods should raise errors if it's invalid.
  def perform_slide(target)
    if valid_slide?(target)
      @board[@position] = nil
      @position = target
      @board[target] = self
      maybe_promote
    end
  end
  
  def perform_jump(target)
    if valid_jump?(target)
      @board[@position] = nil
      @board[jumped_tile(target)] = nil
      @position = target
      @board[target] = self
      maybe_promote
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
        # TA: extract Board#on_board? method.
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
    color = @color == :red ? :red : :light_white
    if @promoted
      return " \u2654 ".colorize(:color => color, :background => :black)
    else
      symbol = " \u25CE " # " \u25CE " " \u274D "
      return symbol.colorize(:color => color, :background => :black)
    end
  end
end