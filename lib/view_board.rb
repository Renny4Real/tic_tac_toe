# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
  end

  def execute
    current_game = @player_gateway.retrieve_board
    if @player_gateway.game_start
      { board: NEW_BOARD, status: nil }
    else
      status = CheckBoard.new(board: current_game).execute
      { board: current_game, status: status }
    end
  end

  NEW_BOARD = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']].freeze
  
end
