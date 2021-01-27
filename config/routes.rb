Rails.application.routes.draw do
  get 'games', to: 'games#index'
  get 'all_games', to: 'games#all_games'
end
