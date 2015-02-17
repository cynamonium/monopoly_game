module Game
  class Monopoly

    attr_reader :state

    RED_COST = 40
    BLUE_COST = 20

    RED_FINE = 80
    BLUE_FINE = 40

    DICE = 6

    #game_state is just a hash with needed game values

    def initialize(game_state)
      @state = game_state.symbolize_keys
    end

    def turn!(player_uid)
      move!(player_uid) if can_turn?(player_uid)
      pay_fine_for_field!(player_uid) if has_to_pay?(player_uid)
    end

    def build_house!(player_uid, type, amount)
      pay_for_house!(player_uid, type, amount) if can_build?(player_uid, type, amount)
      finish_turn!(player_uid)
    end


    def can_turn?(player_uid)
      player_uid == @state[:next_play]
    end

    def can_build?(player_uid, type, amount)
      return false unless can_turn?(player_uid) #still must be players turn
      return can_build_red?(player_uid, amount) if type == 'red'
      return can_build_blue?(player_uid, amount) if type == 'blue'
      false
    end

    def has_to_pay?(player_uid)

    end

    def which_player?(player_uid)
      return 'player_1' if @state[:player_1] == player_uid
      return 'player_2' if @state[:player_2] == player_uid
    end

    def opponent_player?(player_uid)
      return :player_2 if @state[:player_1] == player_uid
      return :player_1 if @state[:player_2] == player_uid
    end

    def finish_turn!(player_uid)
      @state[:next_play] =  @state[opponent_player?(player_uid)] #if his not in jail
    end

    def jail?(player_uid)

    end


    private

    def can_build_red?(player_uid, amount)
      idx = player_field(player_uid)
      free_place?(@state[:fields][idx][:red_houses], player_uid, amount)
    end

    def can_build_blue?(player_uid, amount)
      idx = player_field(player_uid)
      free_place?(@state[:fields][idx][:blue_houses], player_uid, amount)
    end

    def free_place?(place, player_uid, amount)
      place.count + amount < 2  && (place.include?(player_uid) || place.empty?)
    end

    def pay_for_house!(player_uid, type, amount)
      player = which_player?(player_uid)
      idx = player_field(player_uid)
      @state[:fields][idx]["#{type}_houses".to_sym] += Array.new(amount, player_uid)
      @state["#{player}_cash".to_sym] -= amount*RED_COST
    end

    def pay_fine_for_field!(player_uid)

    end

    def player_field(player_uid)
      @state[:fields].index{|f| f[:players].include?(player_uid)}
    end

    def move!(player_uid)
      idx = player_field(player_uid)
      @state[:fields][idx][:players].delete(player_uid)
      @state[:fields][new_position(idx)][:players] << player_uid
    end

    def new_position(current)
      pos =  current + rand(1..DICE)
      return 0 if pos >= 30
      pos
    end

  end
end



