# frozen_string_literal: true

class CheckBoard
  def initialize(board:)
    @board = board
  end

  def execute
    return :X_wins if win?(:X)
    return :O_wins if win?(:O)
    return nil if count_dashes != 9
    :draw
  end

  private

  def win?(type)
    diagonal?(type) || vertical?(type) || horizontal?(type)
  end

  def diagonal?(type)
    diagonal_forward?(type) || diagonal_backward?(type)
  end

  def vertical?(type)
    left_column?(type) || middle_column?(type) || right_column?(type)
  end

  def horizontal?(type)
    top_row?(type) || middle_row?(type) || bottom_row?(type)
  end

  def diagonal_forward?(type)
    [@board[0][0], @board[1][1], @board[2][2]] == [type, type, type]
  end

  def diagonal_backward?(type)
    [@board[0][2], @board[1][1], @board[2][0]] == [type, type, type]
  end

  def left_column?(type)
    [@board[0][0], @board[1][0], @board[2][0]] == [type, type, type]
  end

  def middle_column?(type)
    [@board[0][1], @board[1][1], @board[2][1]] == [type, type, type]
  end

  def right_column?(type)
    [@board[0][2], @board[1][2], @board[2][2]] == [type, type, type]
  end

  def top_row?(type)
    [@board[0][0], @board[0][1], @board[0][2]] == [type, type, type]
  end

  def middle_row?(type)
    [@board[1][0], @board[1][1], @board[1][2]] == [type, type, type]
  end

  def bottom_row?(type)
    [@board[2][0], @board[2][1], @board[2][2]] == [type, type, type]
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

  def return_no_status
    { status: nil }
  end

  def count_dashes
    9 - @board.flatten.count('-')
  end
end
