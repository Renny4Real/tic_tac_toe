# frozen_string_literal: true

describe CheckBoard do
  let(:check_board){ CheckBoard.new }
  it 'can return empty string for an empty board' do
    check_board = CheckBoard.new
    expect(check_board.execute(nil)).to eq('')
  end

  it 'can return X as the winner from diagonal forward ' do
    player_gateway = double(placing_xos: [
                              Player.new(:X, 0, 0),
                              Player.new(:O, 0, 2),
                              Player.new(:X, 1, 1),
                              Player.new(:O, 1, 2),
                              Player.new(:X, 2, 2)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('X has won')
  end

  it 'can return X as the winner from diagonal backward ' do
    player_gateway = double(placing_xos: [
                              Player.new(:X, 0, 2),
                              Player.new(:O, 0, 1),
                              Player.new(:X, 1, 1),
                              Player.new(:O, 1, 2),
                              Player.new(:X, 2, 0)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('X has won')
  end

  it 'can return O as the winner from diagonal forward' do
    player_gateway = double(placing_xos: [
                              Player.new(:O, 0, 0),
                              Player.new(:X, 0, 2),
                              Player.new(:O, 1, 1),
                              Player.new(:X, 1, 2),
                              Player.new(:O, 2, 2)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('O has won')
  end

  it 'can return O as the winner from diagonal backward ' do
    player_gateway = double(placing_xos: [
                              Player.new(:O, 0, 2),
                              Player.new(:X, 0, 1),
                              Player.new(:O, 1, 1),
                              Player.new(:X, 1, 2),
                              Player.new(:O, 2, 0)
                            ])
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)).to eq('O has won')
  end

  context 'Winning for X' do
    it 'can return X as the winner from vertical left ' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 0, 0),
                                Player.new(:O, 0, 1),
                                Player.new(:X, 1, 0),
                                Player.new(:O, 1, 2),
                                Player.new(:X, 2, 0)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end

    it 'can return X as the winner from vertical middle' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 0, 1),
                                Player.new(:O, 0, 0),
                                Player.new(:X, 1, 1),
                                Player.new(:O, 1, 2),
                                Player.new(:X, 2, 1)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end

    it 'can return X as the winner from vertical right ' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 0, 2),
                                Player.new(:O, 0, 1),
                                Player.new(:X, 1, 2),
                                Player.new(:O, 1, 0),
                                Player.new(:X, 2, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end

    it 'can return X as the winner from horizontal top ' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 0, 0),
                                Player.new(:O, 1, 1),
                                Player.new(:X, 0, 1),
                                Player.new(:O, 1, 0),
                                Player.new(:X, 0, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end

    it 'can return X as the winner from horizontal middle ' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 1, 0),
                                Player.new(:O, 0, 1),
                                Player.new(:X, 1, 1),
                                Player.new(:O, 2, 0),
                                Player.new(:X, 1, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end

    it 'can return X as the winner from horizontal bottom ' do
      player_gateway = double(placing_xos: [
                                Player.new(:X, 2, 0),
                                Player.new(:O, 1, 1),
                                Player.new(:X, 2, 1),
                                Player.new(:O, 1, 0),
                                Player.new(:X, 2, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('X has won')
    end
  end

  context 'Winning for O' do
    it 'can return O as the winner from vertical left ' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 0, 0),
                                Player.new(:X, 0, 1),
                                Player.new(:O, 1, 0),
                                Player.new(:X, 1, 2),
                                Player.new(:O, 2, 0)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end

    it 'can return O as the winner from vertical middle' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 0, 1),
                                Player.new(:X, 0, 0),
                                Player.new(:O, 1, 1),
                                Player.new(:X, 1, 2),
                                Player.new(:O, 2, 1)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end

    it 'can return O as the winner from vertical right ' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 0, 2),
                                Player.new(:X, 0, 1),
                                Player.new(:O, 1, 2),
                                Player.new(:X, 1, 0),
                                Player.new(:O, 2, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end

    it 'can return O as the winner from horizontal top ' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 0, 0),
                                Player.new(:X, 1, 1),
                                Player.new(:O, 0, 1),
                                Player.new(:X, 1, 0),
                                Player.new(:O, 0, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end

    it 'can return O as the winner from horizontal middle ' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 1, 0),
                                Player.new(:X, 0, 1),
                                Player.new(:O, 1, 1),
                                Player.new(:X, 2, 0),
                                Player.new(:O, 1, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end

    it 'can return O as the winner from horizontal bottom ' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 2, 0),
                                Player.new(:X, 1, 1),
                                Player.new(:O, 2, 1),
                                Player.new(:X, 1, 0),
                                Player.new(:O, 2, 2)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq('O has won')
    end
  end

end
