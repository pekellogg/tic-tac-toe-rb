# all winning outcomes of tic tac toe
WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [6, 4, 2],
    [0, 4, 8]
]

# all outcomes representing empty positions on board
EMPTY_INDEX_SIGNAL = [nil, "", " "]

# initialize game of tic tac toe
def play(board)
    until over?(board)
      turn(board)
    end
    game_over(board)
end

# if over? generate appropriate message to user(s)
def game_over(board)
    if over?(board)
        won?(board) ? puts("Congratulations #{winner(board)}!") : puts("Cat's Game!")
    else
        false
    end
end

# display board state
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

## control flow method ## prompt user for input, if valid move update board then display updated board state else turn
def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    input = input_to_index(input)
    if valid_move?(board, input)
        move(board, input, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

# convert input
def input_to_index(input)
    input = input.to_i - 1
end
  
# validate with !position_taken? AND input between 0-8 inclusively
def valid_move?(board, input)
    position_taken?(board, input) == false && input.between?(0, 8) ? true : false
end

# update board
def move(board, input, player_token)
    board[input] = player_token
end
  
# if index is NOT nil OR " " OR "" return true
def position_taken?(board, index)
    EMPTY_INDEX_SIGNAL.include?(board[index]) ? false : true
end
  
# board is not full if board contains nil or "" or " "
def full?(board)
    (EMPTY_INDEX_SIGNAL & board).empty? ? true : false
end
  
# if no winner, check if board is full
def draw?(board)
    if !won?(board) then full?(board) end
end
  
# if no winner, is there a draw?
def over?(board)
    won?(board) || draw?(board)
end
  
# return winning combination else false
def won?(board)
    WIN_COMBINATIONS.each do |combination|
      p1 = board[combination[0]]
      p2 = board[combination[1]]
      p3 = board[combination[2]]
      
      if position_taken?(board, combination[0]) && p1 == p2 && p2 == p3
        return combination
      end
    end
    false
end
  
# if won? return winning player's token else false
def winner(board)
    winning_combo = won?(board)
    if winning_combo then board[winning_combo[0]] end
end
  
# count player-occupied board spaces to determine turns taken
def turn_count(board)
    count = 0
    board.each {|i| if i.casecmp?("x") || i.casecmp?("o")
        count += 1
    end
    }
    count
end

# assuming player x has first turn, returns current player based upon turn_count
def current_player(board)
    count = turn_count(board)
    count % 2 == 0 ? "X" : "O"
end