require 'test_helper'
require 'securerandom'

class BoardTest < ActiveSupport::TestCase

  test "return open board or create new  - there is no open board" do
    board = Board.find_open_game_or_create(fresh_pid)
    assert_not_nil board.id
  end

  test "return open board or create new  - there is a open board" do
    first_board = Board.find_open_game_or_create(fresh_pid)
    board       = Board.find_open_game_or_create(fresh_pid)
    assert_not_nil board.id
    assert_equal first_board.id, board.id
  end

  def fresh_pid
    SecureRandom.uuid
  end

end
