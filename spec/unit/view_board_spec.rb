# frozen_string_literal: true

describe ViewBoard do
  def view_marks_on_board(board, expected)
    view_board = ViewBoard.new(player_gateway: double(get_board: board))
    response = view_board.execute
    expect(response). to eq expected
  end

  it 'can view an empty board' do
    view_marks_on_board(nil, board: [
                          ['-', '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ])
  end

  it 'can view a board with an X piece with coordinates in 0,0' do
    view_marks_on_board([
                          [:X, '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ], board: [
                          [:X, '-', '-'],
                          ['-', '-', '-'],
                          ['-', '-', '-']
                        ])
  end

  it 'can view a board with an X piece coordinates in 1,1' do
    view_marks_on_board([
                          ['-', '-', '-'],
                          ['-', :X, '-'],
                          ['-', '-', '-']
                        ], board: [
                          ['-', '-', '-'],
                          ['-', :X, '-'],
                          ['-', '-', '-']
                        ])
  end

  it 'can view a board with an O piece coordinates in 1,1' do
    view_marks_on_board([
                          ['-', '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ], board: [
                          ['-', '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ])
  end

  it 'can view a board with an X at coordinates at (1,1) and O at coordinates(0,1)' do
    view_marks_on_board([
                          [:X, '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ], board: [
                          [:X, '-', '-'],
                          ['-', :O, '-'],
                          ['-', '-', '-']
                        ])
  end

  it 'can view a board with multiple marks ' do
    view_marks_on_board([
                          [:X, '-', '-'],
                          ['-', :X, '-'],
                          [:O, '-', :O]
                        ], board: [
                          [:X, '-', '-'],
                          ['-', :X, '-'],
                          [:O, '-', :O]
                        ])
  end
end
