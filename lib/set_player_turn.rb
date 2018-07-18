# frozen_string_literal: true

class SetPlayerTurn
  def initialize(player_gateway:)
    @player_gateway = player_gateway
  end

  def execute(player: :X)
    @player_gateway.placing_xos = Player.new(:X, 1, 1)
  end
end
