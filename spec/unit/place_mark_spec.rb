# frozen_string_literal: true

describe PlaceMark do

  it 'puts X after player turn ' do
    player_gateway = spy
    update_board = PlaceMark.new(player_gateway: player_gateway)
    response = update_board.execute(player: :X, x: 1, y: 0)
    expect(response).to eq(board: [
                             ['-', '-', '-'],
                             [:X, '-', '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'puts X and then O after player X turn ' do
    player_gateway = spy
    update_board = PlaceMark.new(player_gateway: player_gateway)
    update_board.execute(player: :O, x: 0, y: 0)
    response = update_board.execute(player: :X, x: 1, y: 0)
    expect(response).to eq(board: [
                             [:O, '-', '-'],
                             [:X, '-', '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'puts X and O multiple times ' do
    player_gateway = spy
    update_board = PlaceMark.new(player_gateway: player_gateway)
    update_board.execute(player: :O, x: 0, y: 0)
    update_board.execute(player: :X, x: 2, y: 2)
    update_board.execute(player: :O, x: 1, y: 1)
    response = update_board.execute(player: :X, x: 1, y: 0)
    expect(response).to eq(board: [
                             [:O, '-', '-'],
                             [:X, :O, '-'],
                             ['-', '-', :X]
                           ])
  end
end
