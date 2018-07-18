describe 'a game of Tic Tac Toe' do 
  let(:view_board) {ViewBoard.new}

  it 'can display 3x3 board' do 
    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq (
    [
    [- , - , -],
    [- , - , -],
    [- ,- , -],

    ])
  end 
end