Rails.application.routes.draw do
  resources :things

  root to: "things#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
