# frozen_string_literal: true

describe ViewBoard do
  def view_marks_on_board(board, expected, new_game)
    view_board = ViewBoard.new(player_gateway: spy(retrieve_board: board, game_start: new_game))
    response = view_board.execute
    expect(response[:board]).to eq(expected)
  end

  it 'can view an empty board' do
    view_marks_on_board(nil, [
                          ['-', '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ], true)
  end

  it 'can view a board with an X piece with coordinates in 0,0' do
    view_marks_on_board([
                          [:X, '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ], [
                          [:X, '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ], false)
  end

  it 'can view a board with multiple marks ' do
    view_marks_on_board([
                          [:X, '-', '-'],
                          ['-', :X, '-'],
                          [:O, '-', :O]
                        ], [
                          [:X, '-', '-'],
                          ['-', :X, '-'],
                          [:O, '-', :O]
                        ], false)
  end

  it 'can return a incomplete games status and board' do
    view_board = ViewBoard.new(player_gateway: double(retrieve_board: [[:X, '-', '-'],
                                                                       ['-', :X, '-'],
                                                                       [:O, '-', :O]], game_start: false))
    response = view_board.execute
    expect(response).to eq(board: [[:X, '-', '-'],
                                   ['-', :X, '-'],
                                   [:O, '-', :O]], status: nil)
  end

  it 'can return a win status at the end of a game' do
    view_board = ViewBoard.new(player_gateway: double(retrieve_board: [[:X, '-', '-'],
                                                                       ['-', :X, '-'],
                                                                       %i[O O O]], game_start: false))
    response = view_board.execute
    expect(response).to eq(board: [[:X, '-', '-'],
                                   ['-', :X, '-'],
                                   %i[O O O]], status: :O_wins)
  end

  it 'can return a draw status at the end of a game' do
    view_board = ViewBoard.new(player_gateway: spy(retrieve_board: [%i[X O O],
                                                                    %i[O X X],
                                                                    %i[O X O]], game_start: false))
    response = view_board.execute
    expect(response).to eq(board: [%i[X O O],
                                   %i[O X X],
                                   %i[O X O]], status: :draw)
  end
end
