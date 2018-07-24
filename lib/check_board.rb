# frozen_string_literal: true

class CheckBoard
  def initialize
    @score = ''
    @empty_board = [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  end

  def execute(board)
    @check_score = board
    return @score = '' if @check_score == @empty_board
    print_score(board)
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
    @check_score[0][0] == type && @check_score[1][1] == type && @check_score[2][2] == type
  end

  def diagonal_backward?(type)
    @check_score[0][2] == type && @check_score[1][1] == type && @check_score[2][0] == type
  end

  def vertical_left?(type)
    @check_score[0][0] == type && @check_score[1][0] == type && @check_score[2][0] == type
  end

  def vertical_middle?(type)
    @check_score[0][1] == type && @check_score[1][1] == type && @check_score[2][1] == type
  end

  def vertical_right?(type)
    @check_score[0][2] == type && @check_score[1][2] == type && @check_score[2][2] == type
  end

  def horizontal_top?(type)
    @check_score[0][0] == type && @check_score[0][1] == type && @check_score[0][2] == type
  end

  def horizontal_middle?(type)
    @check_score[1][0] == type && @check_score[1][1] == type && @check_score[1][2] == type
  end

  def horizontal_bottom?(type)
    @check_score[2][0] == type && @check_score[2][1] == type && @check_score[2][2] == type
  end

  def print_score_X
    { status: :X_wins }
  end

  def print_score_O
    { status: :O_wins }
  end

  def print_game_over
    { status: :draw }
  end

  def print_score(board)
    if win_X?
      @score = print_score_X
    elsif win_O?
      @score = print_score_O
    elsif not_full?(board)
      @check_score
    else
      @score = print_game_over
    end
  end

  def count_marks(board)
    count = 0
    @check_score = board
    @check_score.each do |sub_array|
      sub_array.each do |s|
        count += 1 if s == :X || s == :O
      end
      count
    end
    count
  end

  def not_full?(board)
    count_marks(board) < 9
  end
end
