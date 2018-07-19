class CurrentBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
    @view_board = ViewBoard.new(player_gateway: @player_gateway)
  end

  def execute(*)
    @view_board.execute
    { board: @board }
  end
end