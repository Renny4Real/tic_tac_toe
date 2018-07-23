# frozen_string_literal: true

describe CheckBoard do
  it 'can return empty string for an empty board' do
    check_board = CheckBoard.new
    expect(check_board.execute).to eq('')
  end

  it 'can return X as the winner' do
    player_gateway = double(placing_xos: [
                              Player.new(:X, 0, 0),
                              Player.new(:O, 0, 2),
                              Player.new(:X, 1, 1),
                              Player.new(:O, 1, 2),
                              Player.new(:X, 2, 2)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    check_board = CheckBoard.new
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('X has won')
  end

  it 'can return O as the winner' do
    player_gateway = double(placing_xos: [
                              Player.new(:O, 0, 0),
                              Player.new(:X, 0, 2),
                              Player.new(:O, 1, 1),
                              Player.new(:X, 1, 2),
                              Player.new(:O, 2, 2)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    check_board = CheckBoard.new
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('O has won')
  end
end
