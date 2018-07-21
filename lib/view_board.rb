# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    if @player_gateway.placing_xos.nil?
      { board: @board }
    else 
      Array(@player_gateway.placing_xos).each do |player|
        @board[player.x_coordinate][player.y_coordinate] = player.type
       end 
       { board: @board }
    end
    { board: @board }
  end
end
