describe SetPlayerTurn do
  it 'puts X after players turn ' do
    player_gateway = spy
    SetPlayerTurn.new(player_gateway: player_gateway).execute({player: :X})
     expect(player_gateway).to have_received(:placing_xos=) do |player|
     expect(player.type).to eq(:X) 
     end 
  end
end