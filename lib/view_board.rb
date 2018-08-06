# frozen_string_literal: true

class ViewBoard
  def initialize(file_board_gateway:)
    @file_board_gateway = file_board_gateway
  end

  def execute
    current_game = @file_board_gateway.retrieve_board
    if @file_board_gateway.game_start
      { board: NEW_BOARD, status: nil }
    else
      status = CheckBoard.new(board: current_game).execute
      { board: current_game, status: status }
    end
  end

  NEW_BOARD = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']].freeze
  
end
