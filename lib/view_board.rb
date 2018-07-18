# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    if @player_gateway.placing_xos.nil?
      { board: @board }
    elsif @player_gateway.placing_xos.type == :O
      @board[@player_gateway.placing_xos.x_coordinate][@player_gateway.placing_xos.y_coordinate] = :O
      {board: @board}
    else
    @board[@player_gateway.placing_xos.x_coordinate][@player_gateway.placing_xos.y_coordinate] = :X
      { board: @board }
    end
  end
end
