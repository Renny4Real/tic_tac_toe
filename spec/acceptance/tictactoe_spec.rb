describe 'a game of Tic Tac Toe' do 
  class InMemoryPlayerGateway
    def placing_xos
      @placing_xos
    end

    def placing_xos=(placing_xos)
      @placing_xos = placing_xos
    end
  end 

  let(:view_board) {ViewBoard.new(player_gateway: player_gateway)}
  let(:set_player_turn) {SetPlayerTurn.new(player_gateway: player_gateway)}
  let(:player_gateway) {InMemoryPlayerGateway.new}

  it 'can display 3x3 board' do 
    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq (
    [
    ['-' , '-' , '-'],
    ['-', '-' , '-'],
    ['-' , '-' , '-']
    ])
  end 

  it 'can display board after player one plays' do
    set_player_turn.execute(player: :X)
  
    response = view_board.execute({})
    board = response[:board]
    expect(board). to eq (
    [
    ['-' , '-' , '-'],
    ['-', :X , '-'],
    ['-' , '-' , '-']
    ])

  end 
end