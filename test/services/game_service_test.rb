require 'test_helper'
require 'securerandom'

class GameServiceTest < ActiveSupport::TestCase

  test "return open gid or create new  - there is no open board" do
    id = GameService.game_session(fresh_pid)
    assert_not_nil id
  end

  test "return open gid or create new  - there is a open board" do
    gid = GameService.game_session(fresh_pid)
    same_gid  = GameService.game_session(fresh_pid)
    new_gid  = GameService.game_session(fresh_pid)
    assert_equal gid, same_gid
    assert_not_equal gid, new_gid
    assert_not_equal same_gid, new_gid
  end

  test "start a game and make a first turn and build one red house" do
    player_1 = fresh_pid
    player_2 = fresh_pid
    game  = GameService.new(new_game(player_1, player_2))
    game.turn!(player_1)
    game.build_house!(player_1, 'red', 1)
    index = game.state.fields.index{|f| f[:players].include?(player_1)}
    red_house = game.state.fields[index][:red_houses]
    #btw: checks if data was persisted
    assert_not_equal 0, index
    assert_equal red_house[0], player_1
    assert_equal red_house.count, 1
    assert_equal game.state.next_play, player_2
  end

  def fresh_pid
    SecureRandom.uuid
  end

  def new_game(player_1, player_2)
    gid = GameService.game_session(player_1)
    GameService.game_session(player_2)
    gid
  end

end