# frozen_string_literal: true

require 'json'

describe FileBoardGateway do
  it 'will save an updated board' do
    file_board_gateway = FileBoardGateway.new
    file_board_gateway.save_board([
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
    file_board_gateway = FileBoardGateway.new
    file_board_gateway.save_board([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    board = file_board_gateway.retrieve_board

    expect(board).to eq([
                          [:X, '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ])
  end
  it 'will save an updated a board twice' do
    file_board_gateway = FileBoardGateway.new
    file_board_gateway.save_board([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    file_board_gateway.save_board([
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

  it 'can a delete a stored board' do
    file_board_gateway = FileBoardGateway.new
    file_board_gateway.wipe_board

    file = File.read('gamestate.json')

    expect(file).to eq('')
  end
end
