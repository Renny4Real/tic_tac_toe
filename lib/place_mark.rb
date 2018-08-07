# frozen_string_literal: true

# Creates new player mark and position and places on the board
require 'AI'

class PlaceMark
  def initialize(file_board_gateway:)
    @file_board_gateway = file_board_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(player:, x: 'row', y: 'column')
    if player == :O && x == 'row'
      move = best_play
      x = assign_x_coordinate(move)
      y = assign_y_coordinate(move)
    end

    return { board: @board } if %i[O X].include?(@board[x][y])
    @board[x][y] = player
    update_saved_board
  end

  private
  
  def best_play
    AI.new(board: @board).execute
  end

  def update_saved_board
    @file_board_gateway.save_board(@board)
    { board: @board }
  end

  def assign_x_coordinate(move)
    return 0 if move <= 2
    return 1 if [3, 4, 5].include?(move)
    2
  end

  def assign_y_coordinate(move)
    move % 3
  end
end
