# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    Array(@player_gateway.placing_xos).each do |player|
      if check_dup?(player.x_coordinate, player.y_coordinate)
        { board: @board }
      else
        @board[player.x_coordinate][player.y_coordinate] = player.type
      end
    end

    { board: @board }
  end

  private
  
  def check_dup?(x, y)
    @board[x][y] == :O || @board[x][y] == :X
  end
end
