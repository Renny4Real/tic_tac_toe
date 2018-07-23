# frozen_string_literal: true

describe 'a game of Tic Tac Toe' do
  class InMemoryPlayerGateway
    attr_reader :placing_xos

    attr_writer :placing_xos
  end

  let(:view_board) { ViewBoard.new(player_gateway: player_gateway) }
  let(:place_mark) { PlaceMark.new(player_gateway: player_gateway) }
  let(:current_board) { CurrentBoard.new(player_gateway: player_gateway) }
  let(:player_gateway) { InMemoryPlayerGateway.new }
  let(:check_board) { CheckBoard.new }

  it 'can display 3x3 board' do
    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq(
      [
        ['-', '-', '-'],
        ['-', '-', '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display board after player one plays' do
    place_mark.execute(player: :X, x: 1, y: 1)

    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq(
      [
        ['-', '-', '-'],
        ['-', :X, '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display board after player one plays with coordinates' do
    place_mark.execute(player: :X, x: 1, y: 1)

    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq(
      [
        ['-', '-', '-'],
        ['-', :X, '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display board with O' do
    place_mark.execute(player: :O, x: 1, y: 1)

    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq(
      [
        ['-', '-', '-'],
        ['-', :O, '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display board after player twos turn' do
    place_mark.execute(player: :O, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :X, x: 1, y: 1)
    response = view_board.execute({})
    board = response[:board]

    expect(board). to eq(
      [
        [:O, '-', '-'],
        ['-', :X, '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can place only one mark in one x,y coordinates' do
    place_mark.execute(player: :O, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :X, x: 0, y: 0)
    response = view_board.execute({})
    board = response[:board]

    expect(board). to eq(
      [
        [:O, '-', '-'],
        ['-', '-', '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can place multiple marks' do
    place_mark.execute(player: :O, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :X, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :X, x: 1, y: 1)
    response = view_board.execute({})
    board = response[:board]

    expect(board). to eq(
      [
        [:O, '-', '-'],
        ['-', :X, '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display copy of the board' do
    response = current_board.execute({})
    board = response[:board]
    expect(board). to eq(
      [
        ['-', '-', '-'],
        ['-', '-', '-'],
        ['-', '-', '-']
      ]
    )
  end

  it 'can display copy of the board' do
    response = view_board.execute({})
    board = response[:board]
    expect(check_board.execute(board)). to eq('')
  end

  it 'determines the winner when theres a X match across' do
    place_mark.execute(player: :X, x: 1, y: 1)
    view_board.execute({})

    place_mark.execute(player: :O, x: 0, y: 2)
    view_board.execute({})

    place_mark.execute(player: :X, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :O, x: 1, y: 2)
    view_board.execute({})

    place_mark.execute(player: :X, x: 2, y: 2)
    response = view_board.execute({})
    board = response[:board]

    expect(check_board.execute(board)). to eq('X has won')
  end

  it 'determines the winner when theres a O match across' do
    place_mark.execute(player: :O, x: 1, y: 1)
    view_board.execute({})

    place_mark.execute(player: :X, x: 0, y: 2)
    view_board.execute({})

    place_mark.execute(player: :O, x: 0, y: 0)
    view_board.execute({})

    place_mark.execute(player: :X, x: 1, y: 2)
    view_board.execute({})

    place_mark.execute(player: :O, x: 2, y: 2)
    response = view_board.execute({})
    board = response[:board]

    expect(check_board.execute(board)). to eq('O has won')
  end
end
