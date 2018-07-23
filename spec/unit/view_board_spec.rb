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
    player_gateway = double(placing_xos: [
                              Player.new(:O, 1, 1),
                              Player.new(:X, 0, 0)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       [:X, '-', '-'],
                                       ['-', :O, '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can view a board with only one mark in one x,y coordinates' do
    player_gateway = double(placing_xos: [
                              Player.new(:O, 0, 0),
                              Player.new(:X, 0, 0)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       [:O, '-', '-'],
                                       ['-', '-', '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can view a board with multiple marks ' do
    player_gateway = double(placing_xos: [
                              Player.new(:O, 0, 0),
                              Player.new(:X, 0, 0),
                              Player.new(:X, 1, 1)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       [:O, '-', '-'],
                                       ['-', :X, '-'],
                                       ['-', '-', '-']
                                     ])
  end

  it 'can display copy of the board' do
    current_board = CurrentBoard.new(player_gateway: double(placing_xos: nil))
    expect(current_board.execute).to eq(board: [
                                          ['-', '-', '-'],
                                          ['-', '-', '-'],
                                          ['-', '-', '-']
                                        ])
  end

  it 'can view a board with an O piece coordinates in 1,1' do
    player_gateway = double(placing_xos: Player.new(:O, 1, 1))

    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
                                       ['-', '-', '-'],
                                       ['-', :O, '-'],
                                       ['-', '-', '-']
                                     ])
  end
end
