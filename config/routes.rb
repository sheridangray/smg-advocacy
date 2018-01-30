Rails.application.routes.draw do
  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  post '/call', to: 'twilio#call', as: 'call'
  post '/twilio/voice' => 'twilio#voice'
  post '/connect/:target_phone/', to: 'twilio#connect', as: 'connect'
end
