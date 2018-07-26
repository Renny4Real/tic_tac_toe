# frozen_string_literal: true

# Creates new player mark and position and places on the board

class PlaceMark
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(player:, x:, y:)
    if check_dup?(x, y)
      { board: @board }
    else
      @board.each { @board[x][y] = player }
    end
    @player_gateway.get_board = @board
    { board: @board }
  end

  private

  def check_dup?(x, y)
    coordinate_has_O?(x,y) || coordinate_has_X?(x,y)
  end

  def coordinate_has_O?(x,y)
    @board[x][y] == :O
  end

  def coordinate_has_X?(x,y)
    @board[x][y] == :X
  end
end
