# frozen_string_literal: true

describe AI do
  it 'picks the best move' do
    board = [[:X, '-', :O], [:O, '-', '-'], %i[O X X]]

    response = AI.new(board: board).execute

    expect(response).to eq(4)
  end

  it 'can pick the only option left on the board' do
    board = [%i[O X O], %i[O X X], [:X, '-', :O]]

    response = AI.new(board: board).execute

    expect(response).to eq(7)
  end

  it 'can pick another only option left on the board' do
    board = [%i[X X O], %i[O X X], ['-', :O, :O]]

    response = AI.new(board: board).execute

    expect(response).to eq(6)
  end

  it 'can pick a winning solution from two options' do
    board = [%i[X X O], ['-', :X, :O], [:X, :O, '-']]

    response = AI.new(board: board).execute

    expect(response).to eq(8)
  end

  it 'can pick a winning solution from two options' do
    board = [[:O, '-', :O], %i[O X X], [:X, '-', :X]]

    response = AI.new(board: board).execute

    expect(response).to eq(1)
  end

  it 'can pick draw over a loss from two options' do
    board = [%i[X O X], ['-', '-', :O], %i[O X X]]

    response = AI.new(board: board).execute

    expect(response).to eq(4)
  end
end
