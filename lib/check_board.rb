# frozen_string_literal: true

class CheckBoard
  def initialize(player_gateway: player_gateway)
    @player_gateway = player_gateway
    @score = ''
    @check_score = @player_gateway.get_board
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end

  def execute(*)
    if @player_gateway.get_board.nil?
      @board 
    else 
      @check_score
      print_score
    end 
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
    @check_score[0][0] == type \
    && @check_score[1][1] == type \
    && @check_score[2][2] == type
  end

  def diagonal_backward?(type)
    @check_score[0][2] == type \
    && @check_score[1][1] == type \
    && @check_score[2][0] == type
  end

  def vertical_left?(type)
    @check_score[0][0] == type \
    && @check_score[1][0] == type \
    && @check_score[2][0] == type
  end

  def vertical_middle?(type)
    @check_score[0][1] == type \
    && @check_score[1][1] == type \
    && @check_score[2][1] == type
  end

  def vertical_right?(type)
    @check_score[0][2] == type \
    && @check_score[1][2] == type \
    && @check_score[2][2] == type
  end

  def horizontal_top?(type)
    @check_score[0][0] == type \
    && @check_score[0][1] == type \
    && @check_score[0][2] == type
  end

  def horizontal_middle?(type)
    @check_score[1][0] == type \
    && @check_score[1][1] == type \
    && @check_score[1][2] == type
  end

  def horizontal_bottom?(type)
    @check_score[2][0] == type \
    && @check_score[2][1] == type \
    && @check_score[2][2] == type
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

  def print_score
    if win_X?
      @score = return_X_wins_status
    elsif win_O?
      @score = return_O_wins_status
    elsif not_full?
      @check_score
    else
      @score = return_draw_status
    end
  end

  def count_empty_dashes
    @check_score.flatten.count('-')
  end

  def not_full?
    count_empty_dashes != 0
  end
end
