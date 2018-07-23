# frozen_string_literal: true

class Player
  def initialize(type, x_coordinate, y_coordinate)
    @type = type
    @x = x_coordinate
    @y = y_coordinate
  end

  attr_reader :type

  def x_coordinate
    @x
  end

  def y_coordinate
    @y
  end
end
