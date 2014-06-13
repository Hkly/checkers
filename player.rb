class HumanPlayer
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def get_piece
    puts "Move which piece? (ex. 02)"
    gets.chomp.split('').map(&:to_i)
  end
  
  def get_target
    moves =[]
    puts "Move to where? (Enter path as: 51, 33, 15, etc.)"
    input_arr = gets.chomp.split(',')
    input_arr.each do |num_pair|
      moves << num_pair.split('').map(&:to_i)
    end
    moves
  end
  
end