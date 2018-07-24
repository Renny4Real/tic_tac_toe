# frozen_string_literal: true

class CheckBoard
  def initialize
    @score = ''
  end

  def execute(board)
    @check_score = board
    if @check_score.nil?
      @score = ''
    else 
    @check_score.each_with_index do |sub_array , x|
        sub_array.each_with_index do |item , y|
          return @score = print_score_X if diagonal_X? || vertical_X? || horizontal_X?
          return @score = print_score_O if diagonal_O? || vertical_O? || horizontal_O?
      end
    end 
    end
    @score
  end

  private

  def diagonal_X?
    @check_score[0][0] == :X && @check_score[1][1] == :X && @check_score[2][2] == :X ||
    @check_score[0][2] == :X && @check_score[1][1] == :X && @check_score[2][0] == :X 
  end

  def diagonal_O?
    @check_score[0][0] == :O && @check_score[1][1] == :O && @check_score[2][2] == :O ||
    @check_score[0][2] == :O && @check_score[1][1] == :O && @check_score[2][0] == :O 
  end

  def vertical_X?
    @check_score[0][0] == :X && @check_score[1][0] == :X && @check_score[2][0] == :X ||
    @check_score[0][1] == :X && @check_score[1][1] == :X && @check_score[2][1] == :X ||
    @check_score[0][2] == :X && @check_score[1][2] == :X && @check_score[2][2] == :X
  end 

  def vertical_O?
    @check_score[0][0] == :O && @check_score[1][0] == :O && @check_score[2][0] == :O ||
    @check_score[0][1] == :O && @check_score[1][1] == :O && @check_score[2][1] == :O ||
    @check_score[0][2] == :O && @check_score[1][2] == :O && @check_score[2][2] == :O
  end 

  def horizontal_X?
    @check_score[0][0] == :X && @check_score[0][1] == :X && @check_score[0][2] == :X ||
    @check_score[1][0] == :X && @check_score[1][1] == :X && @check_score[1][2] == :X ||
    @check_score[2][0] == :X && @check_score[2][1] == :X && @check_score[2][2] == :X
  end 

  def horizontal_O?
    @check_score[0][0] == :O && @check_score[0][1] == :O && @check_score[0][2] == :O ||
    @check_score[1][0] == :O && @check_score[1][1] == :O && @check_score[1][2] == :O ||
    @check_score[2][0] == :O && @check_score[2][1] == :O && @check_score[2][2] == :O
  end 

  def print_score_X
    'X has won'
  end

  def print_score_O
    'O has won'
  end

end
