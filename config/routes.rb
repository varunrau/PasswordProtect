PasswordProtect::Application.routes.draw do

  get 'log' => 'sessions#new', :as => 'log'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get "sessions/new"
  get "users/new"
  get "sign_up" => "users#new"
  root :to => "users#new"
  resources :users
  resources :sessions

  root :to => "users#new"

end
