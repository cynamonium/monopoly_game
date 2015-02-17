class Board < ActiveRecord::Base
  serialize  :fields

  #simple alias actually
  def to_h
    self.attributes
  end

  def self.find_open_game_or_create(pid)
    @board = Board.where(player_2: nil).where.not(player_1: nil).first
    if @board.present?
      @board.player_2 = pid
      @board.begin_game!
    else
      @board = Board.base_board(pid)
    end
    @board
  end

  def self.base_board(pid)
    board_hash = {
      player_1: pid,
      fields: 30.times.map{|t| {red_houses: [], blue_houses: [], players: [], jail: false}},
      action: 'wait for player 2',
      turns: 0,
      next_play: pid,
      player_1_cash: 1000,
      player_2_cash: 1000
    }
    #set one jail field
    board_hash[:fields][rand(0..29)][:jail] = true
    Board.create(board_hash)
  end


  def begin_game!
    self.fields.first[:players] = [self.player_1, self.player_2]
    self.action = "start"
    self.save
  end

end
