Rails.application.routes.draw do

  root to: 'monopoly#index'
  get '/state'  => 'monopoly#state',  as: :state, defaults: { format: 'json' }
  post '/turn'  => 'monopoly#turn',   as: :turn, defaults: { format: 'json' }
  post '/build'  => 'monopoly#build', as: :build, defaults: { format: 'json' }
end
