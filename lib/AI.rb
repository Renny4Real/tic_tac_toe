# frozen_string_literal: true

class AI
  def initialize(board:)
    @board = board.flatten
  end

  def execute
    scores = score_next_moves
    scores.key(scores.values.max)
  end

  private

  def score_next_moves
    scores = score_tree(:O, @board)
    scores.each_key { |place| scores[place] = score_branch(scores[place], :X) }
    scores
  end

  def score_tree(player, board)
    tree_scores = {}
    check_for_immediate_result(tree_scores, board, player)
    score_child_tree(tree_scores, board, player) if tree_scores.value?(:go_on)
    tree_scores
  end

  def score_branch(branch, player)
    return branch if game_complete?(branch)
    child_scores = []
    branch.each_key { |key| child_scores.push(score(branch, key, player)) }
    min_or_max_scores(child_scores, player)
  end

  def score(branch, key, player)
    return branch[key] if game_complete?(branch[key])
    next_player = switch_player(player)
    score_branch(branch[key], next_player)
  end

  def check_for_immediate_result(tree_scores, board, player)
    list_empty_spaces(board).each do |empty_space|
      board[empty_space] = player
      tree_scores[empty_space] = assign_score(board)
      board[empty_space] = '-'
    end
  end

  def score_child_tree(tree_scores, board, player)
    next_player = switch_player(player)
    tree_scores.each_key do |key|
      next unless tree_scores[key] == :go_on
      board[key] = player
      tree_scores[key] = score_tree(next_player, board)
      board[key] = '-'
    end
  end

  def list_empty_spaces(board)
    empty_spaces = []
    board.each_index { |index| empty_spaces.push(index) if board[index] == '-' }
    empty_spaces
  end

  def min_or_max_scores(scores, player)
    return scores.max if player == :O
    scores.min
  end

  def game_complete?(branch)
    branch.is_a?(Integer)
  end

  def assign_score(board)
    board = board.each_slice(3).to_a
    file_board_gateway = FileBoardGateway.new
    file_board_gateway.save_board(board)
    check_board = CheckBoard.new(file_board_gateway: file_board_gateway)
    return 10 if check_board.execute == :O_wins
    return 0 if check_board.execute == :draw
    return -10 if check_board.execute == :X_wins
    :go_on
  end

  def switch_player(player)
    return :O if player == :X
    :X
  end
end
