# frozen_string_literal: true

describe PlaceMark do
  def update_board(spy_input)
    player_gateway = spy_input
    PlaceMark.new(player_gateway: player_gateway)
  end

  def play_turns(*args)
    board = update_board(spy)
    #    turns = ARGV
    args.each do |turn|
      board.execute(player: turn[0], x: turn[1], y: turn[2])
    end
    board
  end

  it 'puts X after player turn ' do
    update_board = update_board(spy)
    response = update_board.execute(player: :X, x: 1, y: 0)
    expect(response).to eq(board: [
                             ['-', '-', '-'],
                             [:X, '-', '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'puts X and then O after player X turn ' do
    update_board = update_board(spy)
    update_board.execute(player: :O, x: 0, y: 0)
    response = update_board.execute(player: :X, x: 1, y: 0)
    expect(response).to eq(board: [
                             [:O, '-', '-'],
                             [:X, '-', '-'],
                             ['-', '-', '-']
                           ])
  end

  it 'puts X and O multiple times ' do
    update_board = update_board(spy)
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

  it 'picks the best move' do
    board = play_turns([:O, 2, 0], [:X, 0, 0], [:O, 0, 2], [:X, 2, 1], [:O, 1, 0], [:X, 2, 2])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             [:X, '-', :O],
                             [:O, :O, '-'],
                             %i[O X X]
                           ])
  end

  it 'can pick the only option left on the board' do
    board = play_turns([:X, 1, 2], [:O, 0, 0], [:X, 2, 0], [:O, 0, 2], [:X, 0, 1],
                       [:O, 1, 0], [:X, 1, 1], [:O, 2, 2])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             %i[O X O],
                             %i[O X X],
                             %i[X O O]
                           ])
  end

  it 'can pick another only option left on the board' do
    board = play_turns([:O, 2, 1], [:X, 0, 0], [:O, 0, 2], [:X, 0, 1],
                       [:O, 1, 0], [:X, 1, 1], [:O, 2, 2], [:X, 1, 2])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             %i[X X O],
                             %i[O X X],
                             %i[O O O]
                           ])
  end

  it 'can pick a winning solution from two options' do
    board = play_turns([:X, 0, 0], [:O, 0, 2], [:X, 0, 1], [:O, 1, 2],
                       [:X, 2, 0], [:O, 2, 1], [:X, 1, 1])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             %i[X X O],
                             ['-', :X, :O],
                             %i[X O O]
                           ])
  end

  it 'can pick a winning solution from two options' do
    board = play_turns([:X, 1, 1], [:O, 0, 0], [:X, 1, 2], [:O, 0, 2],
                       [:X, 2, 0], [:O, 1, 0], [:X, 2, 2])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             %i[O O O],
                             %i[O X X],
                             [:X, '-', :X]
                           ])
  end

  it 'can pick draw over a loss from two options' do
    board = play_turns([:X, 0, 0], [:O, 0, 1], [:X, 0, 2], [:O, 1, 2],
                       [:X, 2, 1], [:O, 2, 0], [:X, 2, 2])

    response = board.execute(player: :O)

    expect(response).to eq(board: [
                             %i[X O X],
                             ['-', :O, :O],
                             %i[O X X]
                           ])
  end
end
