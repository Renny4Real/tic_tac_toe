describe ViewBoard do

    it 'can view an empty board' do
      view_board = ViewBoard.new(player_gateway: double(placing_xos: nil))
      expect(view_board.execute).to eq(board: [
        ['-' , '-' , '-'],
        ['-', '-' , '-'],
        ['-' , '-' , '-']
        ])
    end  

  it 'can view a board with an X piece' do
    player_gateway = double(placing_xos: Player.new)

    view_board = ViewBoard.new(player_gateway: player_gateway)
    expect(view_board.execute).to eq(board: [
      ['-' , '-' , '-'],
      ['-', :X , '-'],
      ['-' , '-' , '-']
      ])
  end

end 