class HumanPlayer
  def initialize(color)
    @color = color
  end
  
  def get_piece
    puts "Move which piece? (ex. 00, 01, 02)"
    gets.chomp.split('').map(&:to_i)
  end
  
  def get_target
    puts "Move to where?"
    gets.chomp.split('').map(&:to_i)
  end
end