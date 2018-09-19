require "pry"
class Game
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  
  attr_accessor :player_1, :player_2, :board
  
  def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  
  def turn_count
  counter = 0
  board.cells.each do |cells_var|
    if cells_var == "X" || cells_var == "O"
    counter += 1
  end
  end
  counter
end
  
  def current_player
  if turn_count % 2 == 0 
    return @player_1
  else 
    return @player_2
  end
end

def won?
  WIN_COMBINATIONS.detect do |winner|
  board.cells[winner[0]] == board.cells[winner[1]] && board.cells[winner[2]] == board.cells[winner[0]] && board.taken?(winner[0])
  end
end

 def draw?
    !won? && @board.full? ? true : false
  end

def over?
    won? || draw?
end
  
def winner
  won = won?
  if won == nil 
    return nil
  end
  
  position = won[0]
    if board.cells[position] == "X"
      return "X"
    elsif board.cells[position] == "O"
      return "O"
  end 
end

def turn
    puts "Player #{current_player.token}'s turn!"
    puts "Where would you like to move? (1-9): "
    board.display

    user_input = current_player.move(board)

    if board.valid_move?(user_input)
      board.update(user_input, current_player)
    else
      puts "That number is invalid."
      turn
    end
  end
   
  def play
    while !over? 
      turn
    end
      if draw?
        puts "Cat's Game!"
    elsif won?
        puts "Congratulations #{winner}!"
    end
  end


  
end