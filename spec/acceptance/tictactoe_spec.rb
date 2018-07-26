# frozen_string_literal: true

describe 'a game of Tic Tac Toe' do

  let(:view_board) { ViewBoard.new(player_gateway: player_gateway) }
  let(:place_mark) { PlaceMark.new(player_gateway: player_gateway) }
  let(:player_gateway) { InMemoryPlayerGateway.new }
  let(:check_board) { CheckBoard.new(player_gateway: player_gateway) }

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
      place_mark.execute(player: :X, x: 1, y: 1)

      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display board after player one plays with coordinates' do
      place_mark.execute(player: :X, x: 1, y: 1)
      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display board with O' do
      place_mark.execute(player: :O, x: 1, y: 1)

      expect_view_board_block([
                                ['-', '-', '-'],
                                ['-', :O, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can display board after player twos turn' do
      place_mark.execute(player: :O, x: 0, y: 0)
      place_mark.execute(player: :X, x: 1, y: 1)

      expect_view_board_block([
                                [:O, '-', '-'],
                                ['-', :X, '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can place only one mark in one x,y coordinates' do
      place_mark.execute(player: :O, x: 0, y: 0)
      place_mark.execute(player: :X, x: 0, y: 0)

      expect_view_board_block([
                                [:O, '-', '-'],
                                ['-', '-', '-'],
                                ['-', '-', '-']
                              ])
    end

    it 'can place multiple marks' do
      place_mark.execute(player: :O, x: 0, y: 0)
      place_mark.execute(player: :X, x: 0, y: 0)
      place_mark.execute(player: :X, x: 1, y: 1)

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
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 0, y: 2)
        place_mark.execute(player: :X, x: 0, y: 0)
        place_mark.execute(player: :O, x: 1, y: 2)
        place_mark.execute(player: :X, x: 2, y: 2)

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match diagonal backward' do
        place_mark.execute(player: :X, x: 0, y: 2)
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 1, y: 2)
        place_mark.execute(player: :X, x: 2, y: 0)

        response = view_board.execute
        board = response[:board]
        expect_check_board_block(status: :X_wins)
      end
    end

    context 'vertical' do
      it 'determines the winner when theres a X match vertical left' do
        place_mark.execute(player: :X, x: 0, y: 0)
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 1, y: 0)
        place_mark.execute(player: :O, x: 1, y: 2)
        place_mark.execute(player: :X, x: 2, y: 0)

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match vertical middle' do
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 0, y: 0)
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 1, y: 2)
        place_mark.execute(player: :X, x: 2, y: 1)

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match vertical right' do
        place_mark.execute(player: :X, x: 0, y: 2)
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 1, y: 2)
        place_mark.execute(player: :O, x: 1, y: 0)
        place_mark.execute(player: :X, x: 2, y: 2)

        expect_check_board_block(status: :X_wins)
      end
    end

    context 'horizontal' do
      it 'determines the winner when theres a X match horizontal top' do
        place_mark.execute(player: :X, x: 0, y: 0)
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 1, y: 0)
        place_mark.execute(player: :X, x: 0, y: 2)

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match horizontal middle' do
        place_mark.execute(player: :X, x: 1, y: 0)
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 2, y: 0)
        place_mark.execute(player: :X, x: 1, y: 2)

        expect_check_board_block(status: :X_wins)
      end

      it 'determines the winner when theres a X match horizontal bottom' do
        place_mark.execute(player: :X, x: 2, y: 0)
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 2, y: 1)
        place_mark.execute(player: :O, x: 1, y: 0)
        place_mark.execute(player: :X, x: 2, y: 2)

        expect_check_board_block(status: :X_wins)
      end
    end
  end

  context 'O Winning Conditions' do
    context 'diagonal' do
      it 'determines the winner when theres a O match diagonal forward' do
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 0, y: 2)
        place_mark.execute(player: :O, x: 0, y: 0)
        place_mark.execute(player: :X, x: 1, y: 2)
        place_mark.execute(player: :O, x: 2, y: 2)

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match diagonal backward' do
        place_mark.execute(player: :O, x: 0, y: 2)
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 1, y: 2)
        place_mark.execute(player: :O, x: 2, y: 0)

        expect_check_board_block(status: :O_wins)
      end
    end

    context 'vertical' do
      it 'determines the winner when theres a O match vertical left' do
        place_mark.execute(player: :O, x: 0, y: 0)
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 1, y: 0)
        place_mark.execute(player: :X, x: 1, y: 2)
        place_mark.execute(player: :O, x: 2, y: 0)

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match vertical middle' do
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 0, y: 0)
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 1, y: 2)
        place_mark.execute(player: :O, x: 2, y: 1)

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match vertical right' do
        place_mark.execute(player: :O, x: 0, y: 2)
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 1, y: 2)
        place_mark.execute(player: :X, x: 1, y: 0)
        place_mark.execute(player: :O, x: 2, y: 2)

        expect_check_board_block(status: :O_wins)
      end
    end

    context 'horizontal' do
      it 'determines the winner when theres a O match horizontal top' do
        place_mark.execute(player: :O, x: 0, y: 0)
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 0, y: 1)
        place_mark.execute(player: :X, x: 1, y: 0)
        place_mark.execute(player: :O, x: 0, y: 2)

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match horizontal middle' do
        place_mark.execute(player: :O, x: 1, y: 0)
        place_mark.execute(player: :X, x: 0, y: 1)
        place_mark.execute(player: :O, x: 1, y: 1)
        place_mark.execute(player: :X, x: 2, y: 0)
        place_mark.execute(player: :O, x: 1, y: 2)

        expect_check_board_block(status: :O_wins)
      end

      it 'determines the winner when theres a O match horizontal bottom' do
        place_mark.execute(player: :O, x: 2, y: 0)
        place_mark.execute(player: :X, x: 1, y: 1)
        place_mark.execute(player: :O, x: 2, y: 1)
        place_mark.execute(player: :X, x: 1, y: 0)
        place_mark.execute(player: :O, x: 2, y: 2)

        expect_check_board_block(status: :O_wins)
      end
    end
  end

  context 'Draw conditions' do
    it 'All 9 squares are full and neither player has won' do
      place_mark.execute(player: :O, x: 0, y: 0)
      place_mark.execute(player: :X, x: 0, y: 1)
      place_mark.execute(player: :O, x: 0, y: 2)
      place_mark.execute(player: :X, x: 1, y: 0)
      place_mark.execute(player: :O, x: 2, y: 0)
      place_mark.execute(player: :X, x: 1, y: 1)
      place_mark.execute(player: :O, x: 1, y: 2)
      place_mark.execute(player: :X, x: 2, y: 2)
      place_mark.execute(player: :O, x: 2, y: 1)

      expect_check_board_block(status: :draw)
    end

    it 'only return game over if all 9 squares are full and neither player has won' do
      place_mark.execute(player: :O, x: 0, y: 0)
      place_mark.execute(player: :X, x: 0, y: 1)
      place_mark.execute(player: :O, x: 0, y: 2)
      place_mark.execute(player: :X, x: 1, y: 0)
      place_mark.execute(player: :O, x: 1, y: 2)
      place_mark.execute(player: :X, x: 2, y: 2)
      place_mark.execute(player: :O, x: 2, y: 1)

      expect_check_board_block([
                                 %i[O X O],
                                 [:X, '-', :O],
                                 ['-', :O, :X]
                               ])
    end
  end
end
