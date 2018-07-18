class SetPlayerTurn
  def initialize(player_gateway:)
    @player_gateway = player_gateway
  end

  def execute(player: :X)
    @player_gateway.placing_xos = Player.new
  end

end