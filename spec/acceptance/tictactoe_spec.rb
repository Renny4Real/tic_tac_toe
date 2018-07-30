# frozen_string_literal: true

describe 'a game of Tic Tac Toe' do

  let(:view_board) { ViewBoard.new(player_gateway: player_gateway) }
  let(:place_mark) { PlaceMark.new(player_gateway: player_gateway) }
  let(:player_gateway) { InMemoryPlayerGateway.new }
  let(:check_board)   do 
    board = player_gateway.get_board
     CheckBoard.new(board: board) 
  end

  def expect_view_board_block(expected)
    response = view_board.execute
    board = response[:board]
    expect(board). to eq(expected)
  end

  def expect_check_board_block(expected)
    response = view_board.execute
    board = response[:board]
    expect(check_board.execute(board)). to eq(expected)
  end

  def place_marks(*args)
    args.each do |mark|
      place_mark.execute(player: mark[0], x: mark[1], y: mark[2])
    end
  end


  context 'Display Board' do
    it 'can display 3x3 board' do
      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', '-', '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display copy of the board' do
      expect_check_board_block([
                                 ['-', '-', '-'],
                                 ['-', '-', '-'],
                                 ['-', '-', '-']
                               ])
    end

    it 'can display board after player one plays' do
      place_marks([:X, 1, 1])

      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display board with O' do
      place_marks([:O, 1, 1])

      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display board after player twos turn' do
      place_marks([:O, 0, 0], [:X, 1, 1])

      expect_view_board_block([
                                [:O, '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can place only one mark in one x,y coordinates' do
      place_marks([:O, 0, 0], [:X, 0, 0])

      expect_view_board_block([
                                [:O, '-', '-'],
                                ['-', '-', '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can place multiple marks' do
      place_marks([:O, 0, 0], [:X, 0, 0], [:X, 1, 1])

      expect_view_board_block([
                                [:O, '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end
  end

  context 'X Winning Conditions' do
    context 'diagonal' do
      it 'determines the winner when theres a X match diagonal forward' do
        place_marks([:X, 1, 1], [:O, 0, 2], [:X, 0, 0], [:O, 1, 2], [:X, 2, 2])

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match diagonal backward' do
        place_marks([:X, 0, 2], [:O, 0, 1], [:X, 1, 1], [:O, 1, 2], [:X, 2, 0])

        response = view_board.execute
        board = response[:board]
        expect_check_board_block(status: :X_wins)
      end
    end

    context 'vertical' do
      it 'determines the winner when theres a X match vertical left' do
        place_marks([:X, 0, 0], [:O, 0, 1], [:X, 1, 0], [:O, 1, 2], [:X, 2, 0])

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match vertical middle' do
        place_marks([:X, 0, 1], [:O, 0, 0], [:X, 1, 1], [:O, 1, 2], [:X, 2, 1])

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match vertical right' do
        place_marks([:X, 0, 2], [:O, 0, 1], [:X, 1, 2], [:O, 1, 0], [:X, 2, 2])

        expect_check_board_block(status: :X_wins)
      end
    end

    context 'horizontal' do
      it 'determines the winner when theres a X match horizontal top' do
        place_marks([:X, 0 , 0], [:O, 1, 1], [:X, 0, 1], [:O, 1, 0], [:X, 0, 2])

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match horizontal middle' do
        place_marks([:X, 1 , 0], [:O, 0, 1], [:X, 1, 1], [:O, 2, 0], [:X, 1, 2])

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match horizontal bottom' do
        place_marks([:X, 2 , 0], [:O, 1, 1], [:X, 2, 1], [:O, 1, 0], [:X, 2, 2])

        expect_check_board_block(status: :X_wins)
      end
    end
  end

  context 'O Winning Conditions' do
    context 'diagonal' do
      it 'determines the winner when theres a O match diagonal forward' do
        place_marks([:O, 1 , 1], [:X, 0, 2], [:O, 0, 0], [:X, 1, 2], [:O, 2, 2])

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match diagonal backward' do
        place_marks([:O, 0 , 2], [:X, 0, 1], [:O, 1, 1], [:X, 1, 2], [:O, 2, 0])


        expect_check_board_block(status: :O_wins)
      end
    end

    context 'vertical' do
      it 'determines the winner when theres a O match vertical left' do
        place_marks([:O, 0 , 0], [:X, 0, 1], [:O, 1, 0], [:X, 1, 2], [:O, 2, 0])

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match vertical middle' do
        place_marks([:O, 0 , 1], [:X, 0, 0], [:O, 1, 1], [:X, 1, 2], [:O, 2, 1])

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match vertical right' do
        place_marks([:O, 0 , 2], [:X, 0, 1], [:O, 1, 2], [:X, 1, 0], [:O, 2, 2])


        expect_check_board_block(status: :O_wins)
      end
    end

    context 'horizontal' do
      it 'determines the winner when theres a O match horizontal top' do
        place_marks([:O, 0 , 0], [:X, 1, 1], [:O, 0, 1], [:X, 1, 0], [:O, 0, 2])

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match horizontal middle' do
        place_marks([:O, 1 , 0], [:X, 0, 1], [:O, 1, 1], [:X, 2, 0], [:O, 1, 2])

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match horizontal bottom' do
        place_marks([:O, 2 , 0], [:X, 1, 1], [:O, 2, 1], [:X, 1, 0], [:O, 2, 2])

        expect_check_board_block(status: :O_wins)
      end
    end
  end

  context 'Draw conditions' do
    it 'All 9 squares are full and neither player has won' do
      place_marks([:O, 0 , 0], [:X, 0, 1], [:O, 0, 2], [:X, 1, 0], [:O, 2, 0], [:X, 1, 1],
                  [:O, 1, 2], [:X, 2, 2], [:O, 2, 1])

      expect_check_board_block(status: :draw)
    end

    it 'only return game over if all 9 squares are full and neither player has won' do
      place_marks([:O, 0 , 0], [:X, 0, 1], [:O, 0, 2], [:X, 1, 0],
                  [:O, 1, 2], [:X, 2, 2], [:O, 2, 1])

      expect_check_board_block([
                                 %i[O X O],
                                 [:X, '-', :O],
                                 ['-', :O, :X]
                               ])
    end
  end

  context 'AI player' do
    it 'can play a winning move' do
      place_marks([:O, 2, 0], [:X, 0, 0], [:O, 1, 0], [:X, 2, 1], [:O, 0, 2], [:X, 2, 2])

      place_mark.best_play 

      expect_view_board_block([
                                [:X, '-', :O],
                                [:O, :O, '-'],
                                [:O, :X, :X]
                              ])
    end

    xit 'can play the second best starting move' do
      place_marks([:X, 0, 0])

      place_mark.best_play
      expect_view_board_block([
                                [:X, '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    end
  end
end
