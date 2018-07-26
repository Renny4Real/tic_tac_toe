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
  
end
