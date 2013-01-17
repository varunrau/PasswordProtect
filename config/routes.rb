PasswordProtect::Application.routes.draw do
  get "users/new"
  get "sign_up" => "users#new"
  root :to => "users#new"
  resources :users
end
