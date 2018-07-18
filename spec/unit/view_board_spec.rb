# frozen_string_literal: true

describe ViewBoard do
  it 'can view an empty board' do
    view_board = ViewBoard.new(player_gateway: double(placing_xos: nil))
    expect(view_board.execute).to eq(board: [
                                       ['-', '-', '-'],
                                       ['-', '-', '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can view a board with an X piece with coordinates in 0,0' do
    player_gateway = double(placing_xos: Player.new(:X, 0, 0))

    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       [:X, '-', '-'],
                                       ['-', '-', '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can view a board with an X piece coordinates in 1,1' do
    player_gateway = double(placing_xos: Player.new(:X, 1, 1))

    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       ['-', '-', '-'],
                                       ['-', :X, '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can view a board with an X at coordinates at (1,1) and O at coordinates(0,1)' do
    player_gateway= double(placing_xos: Player.new(:O, 0, 0))
    view_board = ViewBoard.new(player_gateway: player_gateway)
    # current_board = CurrentBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       [:O, '-', '-'],
                                       ['-', :X, '-'],
                                       ['-', '-', '-']
                                     ])
  end

end
