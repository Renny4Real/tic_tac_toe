# frozen_string_literal: true

require 'json'

class InMemoryPlayerGateway
  attr_accessor :game_start

  def initialize
    @game_start = true
  end

  def retrieve_board
    file = File.read('gamestate.json')
    data = JSON.parse(file, symbolize_names: true)
    return data if data.nil?
    build_board(data.fetch(:board))
  end

  def save_board(board)
    File.open('gamestate.json', 'w') do |file|
      file.write({ board: board }.to_json)
    end
  end

  def build_board(board)
    board.each do |row|
      row.each_index do |cell|
        row[cell] = :X if row[cell] == 'X'
        row[cell] = :O if row[cell] == 'O'
      end
    end
  end
end
