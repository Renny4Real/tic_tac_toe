# frozen_string_literal: true

describe CheckBoard do
  let(:check_board) { CheckBoard.new }

  def expect_check_board_to_respond_with(_wins, player)
    player_gateway = double(placing_xos: player)
    view_board = ViewBoard.new(player_gateway: player_gateway)
    response = view_board.execute({})
    board = response[:board]
  end

  it 'can return empty string for an empty board' do
    expect(check_board.execute([
                                 ['-', '-', '-'],
                                 ['-', '-', '-'],
                                 ['-', '-', '-']
                               ])).to eq('')
  end

  context 'Winning for X' do
    context 'diagonal' do
      it 'can return X as the winner from diagonal forward ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 0),
                                             Player.new(:O, 0, 2),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 1, 2),
                                             Player.new(:X, 2, 2)
                                           ])
      end

      it 'can return X as the winner from diagonal backward ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 2),
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 1, 2),
                                             Player.new(:X, 2, 0)
                                           ])
      end
    end

    context 'vertical' do
      it 'can return X as the winner from vertical left ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 0),
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 1, 0),
                                             Player.new(:O, 1, 2),
                                             Player.new(:X, 2, 0)
                                           ])
      end

      it 'can return X as the winner from vertical middle' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 0, 0),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 1, 2),
                                             Player.new(:X, 2, 1)
                                           ])
      end

      it 'can return X as the winner from vertical right ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 2),
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 1, 2),
                                             Player.new(:O, 1, 0),
                                             Player.new(:X, 2, 2)
                                           ])
      end
    end

    context 'horizontal' do
      it 'can return X as the winner from horizontal top ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 0, 0),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 1, 0),
                                             Player.new(:X, 0, 2)
                                           ])
      end

      it 'can return X as the winner from horizontal middle ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 1, 0),
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 2, 0),
                                             Player.new(:X, 1, 2)
                                           ])
      end

      it 'can return X as the winner from horizontal bottom ' do
        expect_check_board_to_respond_with(:X_wins, [
                                             Player.new(:X, 2, 0),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 2, 1),
                                             Player.new(:O, 1, 0),
                                             Player.new(:X, 2, 2)
                                           ])
      end
    end
  end

  context 'Winning for O' do
    context 'diagonal' do
      it 'can return O as the winner from diagonal forward' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 0, 0),
                                             Player.new(:X, 0, 2),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 1, 2),
                                             Player.new(:O, 2, 2)
                                           ])
      end

      it 'can return O as the winner from diagonal backward ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 0, 2),
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 1, 2),
                                             Player.new(:O, 2, 0)
                                           ])
      end
    end

    context 'vertical' do
      it 'can return O as the winner from vertical left ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 0, 0),
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 1, 0),
                                             Player.new(:X, 1, 2),
                                             Player.new(:O, 2, 0)
                                           ])
      end

      it 'can return O as the winner from vertical middle' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 0, 0),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 1, 2),
                                             Player.new(:O, 2, 1)
                                           ])
      end

      it 'can return O as the winner from vertical right ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 0, 2),
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 1, 2),
                                             Player.new(:X, 1, 0),
                                             Player.new(:O, 2, 2)
                                           ])
      end
    end

    context 'horizontal' do
      it 'can return O as the winner from horizontal top ' do
        expect_check_board_to_respond_with(:O_wins,  [
                                             Player.new(:O, 0, 0),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 0, 1),
                                             Player.new(:X, 1, 0),
                                             Player.new(:O, 0, 2)
                                           ])
      end

      it 'can return O as the winner from horizontal middle ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 1, 0),
                                             Player.new(:X, 0, 1),
                                             Player.new(:O, 1, 1),
                                             Player.new(:X, 2, 0),
                                             Player.new(:O, 1, 2)
                                           ])
      end

      it 'can return O as the winner from horizontal bottom ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             Player.new(:O, 2, 0),
                                             Player.new(:X, 1, 1),
                                             Player.new(:O, 2, 1),
                                             Player.new(:X, 1, 0),
                                             Player.new(:O, 2, 2)
                                           ])
      end
    end
  end

  context 'Draw Conditions' do
    it 'can return game over if all 9 squares are full and neither player has won ' do
      expect_check_board_to_respond_with(:draw, [
                                           Player.new(:O, 0, 0),
                                           Player.new(:X, 0, 1),
                                           Player.new(:O, 0, 2),
                                           Player.new(:X, 1, 0),
                                           Player.new(:O, 2, 0),
                                           Player.new(:X, 1, 1),
                                           Player.new(:O, 1, 2),
                                           Player.new(:X, 2, 2),
                                           Player.new(:O, 2, 1)
                                         ])
    end

    it 'only return game over if all 9 squares are full and neither player has won' do
      player_gateway = double(placing_xos: [
                                Player.new(:O, 0, 0),
                                Player.new(:X, 0, 1),
                                Player.new(:O, 0, 2),
                                Player.new(:X, 1, 0),
                                Player.new(:O, 1, 2),
                                Player.new(:X, 2, 2),
                                Player.new(:O, 2, 1)
                              ])
      view_board = ViewBoard.new(player_gateway: player_gateway)
      response = view_board.execute
      board = response[:board]
      expect(check_board.execute(board)).to eq([
                                                 %i[O X O],
                                                 [:X, '-', :O],
                                                 ['-', :O, :X]
                                               ])
    end
  end
end
