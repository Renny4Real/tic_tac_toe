# frozen_string_literal: true

describe PlaceMark do

  it 'puts X after players turn ' do
    player_gateway = spy
    PlaceMark.new(player_gateway: player_gateway).execute(player: :X , x: 1 , y: 1)
    expect(player_gateway).to have_received(:placing_xos=) do |player|
    expect(player.type).to eq(:X)
    end
  end

  it 'puts O after players turn ' do
    player_gateway = spy
    PlaceMark.new(player_gateway: player_gateway).execute(player: :O ,x: 0, y: 0)
    expect(player_gateway).to have_received(:placing_xos=) do |player|
    expect(player.type).to eq(:O)
    end
  end

 # same board O and X 
end
