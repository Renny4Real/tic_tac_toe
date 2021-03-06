# frozen_string_literal: true

class ViewBoard
  def initialize(file_board_gateway:)
    @file_board_gateway = file_board_gateway
  end

  def execute
    current_game = @file_board_gateway
    if @file_board_gateway.retrieve_board.nil?
      { board: NEW_BOARD, status: nil }
    else
      status = CheckGameCondition.new(file_board_gateway: current_game).execute
      { board: current_game.retrieve_board, status: status }
    end
  end

  NEW_BOARD = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']].freeze
  
end
