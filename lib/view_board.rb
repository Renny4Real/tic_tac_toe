# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    if @player_gateway.get_board.nil?
      { board: @board }
    else
      { board: @player_gateway.get_board }
    end
  end
end
