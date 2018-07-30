# frozen_string_literal: true

# Creates new player mark and position and places on the board

class PlaceMark
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(player:, x:, y:)
    if [:O, :X].include? (@board[x][y])
      { board: @board }
    else
       @board[x][y] = player 
    end
    @player_gateway.get_board = @board
    { board: @board }
  end

  def best_play
    if @board.flatten.count('-') == 1
      @board = @board.flatten
      @board[@board.index('-')] = :O
      @board = @board.each_slice(3).to_a
    else
      scores = check_next_moves
      best_index = scores.index(scores.max)
      @board = @board.flatten
      @board[best_index] = :O
      @board = @board.each_slice(3).to_a
    end
    @player_gateway.get_board = @board
    { board: @board }
  end

  private

  def check_next_moves
    temp_board = @board
    scores = []
    temp_board.each_index do |sub|
      temp_board[sub].each_index do |index|
       if !(temp_board[sub][index] == '-')
        scores.push(-50)
        next
       end
       temp_board[sub][index] = :O
       scores.push(assign_score(temp_board))
       temp_board[sub][index] = '-'
      end
    end
    scores
  end

  def assign_score(board)
    check_board = CheckBoard.new(board: board)

    return 10 if check_board.execute() == { status: :O_wins }
    return 0 if check_board.execute() == { status: :draw}
    -10
  end

  
end
