# frozen_string_literal: true

require 'json'

describe InMemoryPlayerGateway do
  it 'will save an updated board' do
    player_gateway = InMemoryPlayerGateway.new
    player_gateway.save_board([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])

    file = File.read('gamestate.json')
    result = JSON.parse(file)

    expect(result).to eq('board' => [
                           ['X', '-', '-'],
                           ['-', 'O', '-'],
                           ['-', '-', '-']
                         ])
  end

  it 'will retrieve an updated board' do
    player_gateway = InMemoryPlayerGateway.new
    player_gateway.save_board([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    board = player_gateway.retrieve_board

    expect(board).to eq([
                          [:X, '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ])
  end
  it 'will save an updated a board twice' do
    player_gateway = InMemoryPlayerGateway.new
    player_gateway.save_board([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    player_gateway.save_board([
                                [:X, '-', :X],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])

    file = File.read('gamestate.json')
    result = JSON.parse(file)

    expect(result).to eq('board' => [
                           ['X', '-', 'X'],
                           ['-', 'O', '-'],
                           ['-', '-', '-']
                         ])
  end
end
