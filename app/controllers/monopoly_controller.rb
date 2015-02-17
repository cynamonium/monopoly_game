class MonopolyController < ApplicationController
  before_filter :game_session
  respond_to :json

  def index
    @user_pid = session[:pid]
  end

  #GET
  def state
    respond_with game.state
  end

  #POST
  def build
    game.build_house!(pid, house_type, amount) if build_action?
  end

  #POST
  def turn
    game.turn!(pid) if turn_action?
  end

  private

  def pid
    game_params[:pid]
  end

  def house_type
    game_params[:house_type]
  end

  def amount
    game_params[:amount]
  end

  def turn_action?
    game_params[:action] == 'turn'
  end

  def build_action?
    game_params[:action] == 'build'
  end

  def game
    @game ||= GameService.new(session[:gid])
  end

  def game_params
    return nil_params if params[:game].nil?
    params[:game].permit(:pid, :action, :house_type, :amount)
  end

  def game_session
    #pid - player id
    #gid - game id
    session[:pid] = SecureRandom.uuid unless session[:pid]
    session[:gid] = GameService.game_session(session[:pid]) unless session[:gid]
  end

  def nil_params
    {pid: nil, action: nil, house_type: nil, amount: nil}
  end

end