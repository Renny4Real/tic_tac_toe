# frozen_string_literal: true

class CheckBoard
  def initialize(player_gateway: player_gateway)
    @player_gateway = player_gateway
    @status = ''
    @current_status = @player_gateway.get_board
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    @player_gateway.get_board.nil? ? @board : print_status
  end

  private

  def win_X?
    diagonal?(:X) || vertical?(:X) || horizontal?(:X)
  end

  def win_O?
    diagonal?(:O) || vertical?(:O) || horizontal?(:O)
  end

  def diagonal?(type)
    diagonal_forward?(type) || diagonal_backward?(type)
  end

  def vertical?(type)
    vertical_left?(type) || vertical_middle?(type) || vertical_right?(type)
  end

  def horizontal?(type)
    horizontal_top?(type) || horizontal_middle?(type) || horizontal_bottom?(type)
  end

  def diagonal_forward?(type)
    @current_status[0][0] == type \
    && @current_status[1][1] == type \
    && @current_status[2][2] == type
  end

  def diagonal_backward?(type)
    @current_status[0][2] == type \
    && @current_status[1][1] == type \
    && @current_status[2][0] == type
  end

  def vertical_left?(type)
    @current_status[0][0] == type \
    && @current_status[1][0] == type \
    && @current_status[2][0] == type
  end

  def vertical_middle?(type)
    @current_status[0][1] == type \
    && @current_status[1][1] == type \
    && @current_status[2][1] == type
  end

  def vertical_right?(type)
    @current_status[0][2] == type \
    && @current_status[1][2] == type \
    && @current_status[2][2] == type
  end

  def horizontal_top?(type)
    @current_status[0][0] == type \
    && @current_status[0][1] == type \
    && @current_status[0][2] == type
  end

  def horizontal_middle?(type)
    @current_status[1][0] == type \
    && @current_status[1][1] == type \
    && @current_status[1][2] == type
  end

  def horizontal_bottom?(type)
    @current_status[2][0] == type \
    && @current_status[2][1] == type \
    && @current_status[2][2] == type
  end

  def return_X_wins_status
    @score = { status: :X_wins }
  end

  def return_O_wins_status
    @score = { status: :O_wins }
  end

  def return_draw_status
    @score = { status: :draw }
  end

  def print_status
      return return_X_wins_status if win_X?
      return return_O_wins_status if win_O?
      return @current_status if count_dashes != 9
      return_draw_status
  end

  def count_dashes
    9 - @current_status.flatten.count('-')
  end
end
