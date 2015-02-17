class GameService

  def initialize(gid)
    raise "No gid specified" unless gid
    @board = Board.find(gid)
    @game = Game::Monopoly.new(@board.to_h)
  end

  def turn!(player_uid)
    @game.turn!(player_uid)
    persist!
  end

  def build_house!(player_uid, type, amount)
    @game.build_house!(player_uid, type, amount)
    persist!
  end

  def state
    @board
  end

  def self.game_session(pid)
    board = Board.find_open_game_or_create(pid)
    board.id
  end

  private

  def persist!
    @board.update_attributes(@game.state)
  end

end