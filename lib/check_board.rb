# frozen_string_literal: true

class CheckBoard
  def initialize
    @score = ''
  end

  def execute(*board)
    @check_score = board.reduce
    if @check_score.nil?
      @score = ''

    else 

    @check_score.each_with_index do |sub_array , x|
        sub_array.each_with_index do |item , y|
         if @check_score[x][y] == :X && @check_score[x+1][y+1] == :X && @check_score[x+2][y+2] == :X
          return @score = 'X has won'
         elsif @check_score[x][y] == :O && @check_score[x+1][y+1] == :O && @check_score[x+2][y+2] == :O
          return @score = 'O has won'
        end
      end
    end 
    end
    @score
  end
end
