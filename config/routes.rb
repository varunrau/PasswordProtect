PasswordProtect::Application.routes.draw do

  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get "sessions/new"
  get "users/new"
  get "sign_up" => "users#new"
  resources :users
  resources :sessions

  # Login Page
  get "logins" => 'users#logins', :as => 'logins'
  delete "logins" => 'users#deletelogin', :as => 'logins'
  post 'logins' => 'users#addlogin', :as => 'add_login'
  get "logins" => 'users#search', :as => 'search'

  # Root
  root :to => "users#new"

end
