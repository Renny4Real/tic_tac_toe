# frozen_string_literal: true

#Creates new player mark and position and places on the board

class PlaceMark
  def initialize(player_gateway:)
    @player_gateway = player_gateway
  end

  def execute(player: , x: , y:)
    @player_gateway.placing_xos = Player.new(player, x, y)
    {}
  end
end
