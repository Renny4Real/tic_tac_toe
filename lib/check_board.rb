# frozen_string_literal: true

class CheckBoard
  def initialize(player_gateway: player_gateway)
    @player_gateway = player_gateway
    @current_board = @player_gateway.get_board
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    @current_board.nil? ? @board : print_status
  end

  private

  def win?(type)
    diagonal?(type) || vertical?(type) || horizontal?(type)
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
    [@current_board[0][0], @current_board[1][1], @current_board[2][2]] == [type,type,type]
  end

  def diagonal_backward?(type)
    [@current_board[0][2], @current_board[1][1], @current_board[2][0]] == [type,type,type]
  end

  def vertical_left?(type)
    [@current_board[0][0], @current_board[1][0], @current_board[2][0]] == [type, type, type]
  end

  def vertical_middle?(type)
    [@current_board[0][1], @current_board[1][1], @current_board[2][1]] == [type,type,type]
  end

  def vertical_right?(type)
    [@current_board[0][2], @current_board[1][2], @current_board[2][2]] == [type,type,type]
  end

  def horizontal_top?(type)
    [@current_board[0][0], @current_board[0][1], @current_board[0][2]] == [type,type,type]
  end

  def horizontal_middle?(type)
    [@current_board[1][0], @current_board[1][1], @current_board[1][2]] == [type,type,type]
  end

  def horizontal_bottom?(type)
    [@current_board[2][0], @current_board[2][1], @current_board[2][2]] == [type,type,type]
  end

  def return_X_wins_status
    { status: :X_wins }
  end

  def return_O_wins_status
    { status: :O_wins }
  end

  def return_draw_status
    { status: :draw }
  end

  def print_status
      return return_X_wins_status if win?(:X)
      return return_O_wins_status if win?(:O)
      return @current_board if count_dashes != 9
      return_draw_status
  end

  def count_dashes
    9 - @current_board.flatten.count('-')
  end
end

