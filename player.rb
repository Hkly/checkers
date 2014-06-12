class HumanPlayer
  def initialize(color)
    @color = color
  end
  
  def get_piece
    puts "Move which piece to where? (ex. 02)"
    gets.chomp.split('').map(&:to_i)
  end
  
  def get_target
    moves =[]
    puts "Move to where? (Enter path as: 51, 33, 15, etc.)"
    gets.chomp.split(',').each do |num_pair|
      moves << num_pair.split('').map(&:to_i)
    end
    moves
  end
  
end