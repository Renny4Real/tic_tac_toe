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
      @board.each do |_b|
        @board[x][y] = player
      end
    end
    @player_gateway.get_board = @board
    { board: @board }
  end

  private

  def check_dup?(x, y)
    @board[x][y] == :O || @board[x][y] == :X
  end
end
