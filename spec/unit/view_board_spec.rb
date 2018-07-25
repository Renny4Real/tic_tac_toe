# frozen_string_literal: true

describe ViewBoard do
  def view_marks_on_board(player)
    player_gateway = double(placing_xos: player)
    view_board = ViewBoard.new(player_gateway: player_gateway)
    view_board.execute(player)
  end

  it 'can view an empty board' do
    view_board = ViewBoard.new(player_gateway: double(get_board: nil))
    expect(view_board.execute([
                                ['-', '-', '-'],
                                ['-', '-', '-'],
                                ['-', '-', '-']
                              ])).to eq(board: [
                                          ['-', '-', '-'],
                                          ['-', '-', '-'],
                                          ['-', '-', '-']
                                        ])
  end

  it 'can view a board with an X piece with coordinates in 0,0' do
    player_gateway = double(get_board: [
                             [:X, '-', '-'],
                             ['-', '-', '-'],
                             ['-', '-', '-']
                           ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    expect(response).to eq(board: [
                             [:X, '-', '-'],
                             ['-', '-', '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'can view a board with an X piece coordinates in 1,1' do
    player_gateway = double(get_board: [
                             ['-', '-', '-'],
                             ['-', :X, '-'],
                             ['-', '-', '-']
                           ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    expect(response).to eq(board: [
                             ['-', '-', '-'],
                             ['-', :X, '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'can view a board with an O piece coordinates in 1,1' do
    player_gateway = double(get_board: [
                             ['-', '-', '-'],
                             ['-', :O, '-'],
                             ['-', '-', '-']
                           ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    expect(response).to eq(board: [
                             ['-', '-', '-'],
                             ['-', :O, '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'can view a board with an X at coordinates at (1,1) and O at coordinates(0,1)' do
    player_gateway = double(get_board: [
                             [:X, '-', '-'],
                             ['-', :O, '-'],
                             ['-', '-', '-']
                           ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    expect(response).to eq(board: [
                             [:X, '-', '-'],
                             ['-', :O, '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'can view a board with multiple marks ' do
    player_gateway = double(get_board: [
                             [:X, '-', '-'],
                             ['-', :X, '-'],
                             [:O, '-', :O]
                           ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    expect(response).to eq(board: [
                            [:X, '-', '-'],
                            ['-', :X, '-'],
                            [:O, '-', :O]
                           ])
  end

  
end
