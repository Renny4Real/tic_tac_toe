# frozen_string_literal: true

describe CheckBoard do
  def expect_check_board_to_respond_with(expected, board)
    check_board = CheckBoard.new(player_gateway: double(get_board: board))
    response = check_board.execute
    expect(response).to eq(expected)
  end

  it 'can return empty string for an empty board' do
    check_board = CheckBoard.new(player_gateway: double(get_board: nil))
    expect(check_board.execute).to eq([['-', '-', '-'],
                                       ['-', '-', '-'],
                                       ['-', '-', '-']])
  end

  context 'Winning for X' do
    context 'diagonal' do
      it 'can return X as the winner from diagonal forward ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             [:X, '-', :O],
                                             ['-', :X, :O],
                                             ['-', '-', :X]
                                           ])
      end

      it 'can return X as the winner from diagonal backward ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             ['-', '-', :X],
                                             ['-', :X, :O],
                                             [:X, '-', :O]
                                           ])
      end
    end

    context 'vertical' do
      it 'can return X as the winner from vertical left ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             [:X, '-', '-'],
                                             [:X, '-', :O],
                                             [:X, '-', :O]
                                           ])
      end

      it 'can return X as the winner from vertical middle' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             ['-', :X, '-'],
                                             ['-', :X, :O],
                                             ['-', :X, :O]
                                           ])
      end

      it 'can return X as the winner from vertical right ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             ['-', '-', :X],
                                             ['-', :O, :X],
                                             ['-', :O, :X]
                                           ])
      end
    end

    context 'horizontal' do
      it 'can return X as the winner from horizontal top ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             %i[X X X],
                                             ['-', :O, '-'],
                                             ['-', :O, '-']
                                           ])
      end

      it 'can return X as the winner from horizontal middle ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             ['-', :O, '-'],
                                             %i[X X X],
                                             ['-', :O, '-']
                                           ])
      end

      it 'can return X as the winner from horizontal bottom ' do
        expect_check_board_to_respond_with({ status: :X_wins }, [
                                             ['-', :O, '-'],
                                             ['-', :O, '-'],
                                             %i[X X X]
                                           ])
      end
    end
  end

  context 'Winning for O' do
    context 'diagonal' do
      it 'can return O as the winner from diagonal forward' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             [:O, '-', '-'],
                                             [:X, :O, '-'],
                                             [:X, '-', :O]
                                           ])
      end

      it 'can return O as the winner from diagonal backward ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             ['-', '-', :O],
                                             [:X, :O, '-'],
                                             [:O, :X, '-']
                                           ])
      end
    end

    context 'vertical' do
      it 'can return O as the winner from vertical left ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             [:O, '-', '-'],
                                             [:O, :X, '-'],
                                             [:O, :X, '-']
                                           ])
      end

      it 'can return O as the winner from vertical middle' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             ['-', :O, '-'],
                                             [:X, :O, '-'],
                                             [:X, :O, '-']
                                           ])
      end

      it 'can return O as the winner from vertical right ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             ['-', :O, :O],
                                             %i[X X O],
                                             %i[X X O]
                                           ])
      end
    end

    context 'horizontal' do
      it 'can return O as the winner from horizontal top ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             %i[O O O],
                                             [:X, :X, '-'],
                                             [:X, :X, '-']
                                           ])
      end

      it 'can return O as the winner from horizontal middle ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             ['-', '-', '-'],
                                             %i[O O O],
                                             %i[X O X]
                                           ])
      end

      it 'can return O as the winner from horizontal bottom ' do
        expect_check_board_to_respond_with({ status: :O_wins }, [
                                             ['-', '-', '-'],
                                             [:X, :X, '-'],
                                             %i[O O O]
                                           ])
      end
    end
  end

  context 'Draw Conditions' do
    it 'can return game over if all 9 squares are full and neither player has won ' do
      expect_check_board_to_respond_with({ status: :draw }, [
                                           %i[O X O],
                                           %i[X X O],
                                           %i[O O X]
                                         ])
    end

    it 'only return game over if all 9 squares are full and neither player has won' do
      check_board = CheckBoard.new(player_gateway: double(get_board: [
                                                            %i[O X O],
                                                            [:X, '-', :O],
                                                            ['-', :O, :X]
                                                          ]))

      expect(check_board.execute).to eq([
                                          %i[O X O],
                                          [:X, '-', :O],
                                          ['-', :O, :X]
                                        ])
    end
  end
end
