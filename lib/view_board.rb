class ViewBoard 
  def initialize(player_gateway:)
    @player_gateway = player_gateway
    @board = [
      ['-' , '-' , '-'],
      ['-', '-' , '-'],
      ['-' , '-' , '-']
      ]
  end

  def execute(*)
    if @player_gateway.placing_xos.nil?
      {
        board: @board
      }
    else
      @board = [
      ['-' , '-' , '-'],
      ['-', :X , '-'],
      ['-' , '-' , '-']
      ]
      
      {board: @board}
    end 
  end
end 