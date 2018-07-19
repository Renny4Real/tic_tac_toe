# frozen_string_literal: true

class ViewBoard
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
    @store = []
  end

  def execute(*)
    if @player_gateway.placing_xos.nil? # @store
      { board: @board } 

    #else
      #require 'pry'; {binding:pry}

 # @store.each do |x, y| 
 # if @store.even?
  #@board[x][y] = :X
  # else 
  #@board[x][y] = :O
  #end

  #{ board: @board }

    elsif @player_gateway.placing_xos.type == :X
      @board[@player_gateway.placing_xos.x_coordinate][@player_gateway.placing_xos.y_coordinate] = :X
      {board: @board} 
    else 
    @board[@player_gateway.placing_xos.x_coordinate][@player_gateway.placing_xos.y_coordinate] = :O
      { board: @board }
    end
  end

  # @store.each do
  # |x, y| puts x, y if @store.index.even?
  # else 
  #end

  def store_mark(*marks)
    #[[1,1],[0,0]]
    @store.push(*marks) 
  end
end
