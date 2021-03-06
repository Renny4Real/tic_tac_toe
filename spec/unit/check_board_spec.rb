# frozen_string_literal: true

describe CheckGameCondition do
  def expect_check_board_to_respond_with(expected, board)
    check_board = CheckGameCondition.new(file_board_gateway: spy(retrieve_board: board))
    response = check_board.execute
    expect(response).to eq(expected)
  end

  it 'can return empty string for an empty board' do
    expect_check_board_to_respond_with(nil,
                                       [['-', '-', '-'],
                                        ['-', '-', '-'],
                                        ['-', '-', '-']])
  end

  context 'Winning Condtions' do
    it 'could return X as the winner for a scenario' do
      expect_check_board_to_respond_with(:X_wins, [
                                            [:X, '-', :O],
                                            ['-', :X, :O],
                                            ['-', '-', :X]
                                          ])
    end

    context 'diagonal' do
      it 'can return O as the winner from diagonal forward' do
        expect_check_board_to_respond_with(:O_wins, [
                                             [:O, '-', '-'],
                                             [:X, :O, '-'],
                                             [:X, '-', :O]
                                           ])
      end

      it 'can return O as the winner from diagonal backward ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             ['-', '-', :O],
                                             [:X, :O, '-'],
                                             [:O, :X, '-']
                                           ])
      end
    end

    context 'vertical' do
      it 'can return O as the winner from vertical left ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             [:O, '-', '-'],
                                             [:O, :X, '-'],
                                             [:O, :X, '-']
                                           ])
      end

      it 'can return O as the winner from vertical middle' do
        expect_check_board_to_respond_with(:O_wins, [
                                             ['-', :O, '-'],
                                             [:X, :O, '-'],
                                             [:X, :O, '-']
                                           ])
      end

      it 'can return O as the winner from vertical right ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             ['-', :O, :O],
                                             %i[X X O],
                                             %i[X X O]
                                           ])
      end
    end

    context 'horizontal' do
      it 'can return O as the winner from horizontal top ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             %i[O O O],
                                             [:X, :X, '-'],
                                             [:X, :X, '-']
                                           ])
      end

      it 'can return O as the winner from horizontal middle ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             ['-', '-', '-'],
                                             %i[O O O],
                                             %i[X O X]
                                           ])
      end

      it 'can return O as the winner from horizontal bottom ' do
        expect_check_board_to_respond_with(:O_wins, [
                                             ['-', '-', '-'],
                                             [:X, :X, '-'],
                                             %i[O O O]
                                           ])
      end
    end
  end

  context 'Draw Conditions' do
    it 'will return draw if all 9 squares are full and neither player has won ' do
      expect_check_board_to_respond_with(:draw, [
                                           %i[O X O],
                                           %i[X X O],
                                           %i[O O X]
                                         ])
    end

    it 'will not return a draw if there are empty squares' do
      expect_check_board_to_respond_with(nil,
                                         [%i[O X O],
                                          [:X, '-', :O],
                                          ['-', :O, :X]])
    end

    it 'only returns winner if someone has won' do
      expect_check_board_to_respond_with(nil,
                                         [%i[O X O],
                                          [:X, '-', :O],
                                          ['-', :O, :X]])
    end
  end
end
