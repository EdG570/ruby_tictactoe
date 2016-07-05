def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == ' '}
end

def player_places_piece!(brd)
  user_choice = ''
  loop do
    prompt("Pick a cell: 1 thru 9")
    user_choice = gets.chomp.to_i
    if empty_squares(brd).include?(user_choice)
      break
    else
      prompt("Sorry, that's not a valid choice.")
    end
  end

  brd[user_choice] = 'X'
end

board = initialize_board
display_board(board)

player_places_piece!(board)
display_board(board)
puts board.inspect

#computer_choice = rand(1..9)
# Computer picks a cell
# Display updated board
# If 3 in a row horizontally, vertically or diagnally display winner
# Elsif board is full display tie
# => Ask user if they want to play again
# =>   If yes loop back to display empty board
# =>   If no say "Good bye!"
# Else loop back to ask user to pick a cell (line 2)

