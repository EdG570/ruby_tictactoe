require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6],
                 [7, 8, 9], [1, 4, 7],
                 [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system "clear"
  puts "You're an #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
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
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  user_choice = ''
  loop do
    prompt("Pick a cell: (#{empty_squares(brd).join(', ')})")
    user_choice = gets.chomp.to_i
    break if empty_squares(brd).include?(user_choice)
    prompt("Sorry, that's not a valid choice.")
  end

  brd[user_choice] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  comp_choice = empty_squares(brd).sample
  brd[comp_choice] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do
  board = initialize_board
  display_board(board)

  loop do
    player_places_piece!(board)
    display_board(board)
    break if board_full?(board) || winner?(board)

    computer_places_piece!(board)
    display_board(board)
    break if board_full?(board) || winner?(board)
  end

  if winner?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "The game has ended in a tie!"
  end

  prompt "Would you like to play again? (y or n)"
  user_play = gets.chomp.downcase
  break if user_play != 'y'
end

prompt "Thank you for playing Tic Tac Toe. Good bye!"
