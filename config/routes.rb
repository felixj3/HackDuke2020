Rails.application.routes.draw do
  get 'create_room/index'
  get 'create_room/post'
  root "home#index"
  devise_for :users
  get "request" => "request_tutor#index"
  get "assist" => "become_tutor#index"
  get "study" => "study#index"
  post "/assist" => "become_tutor#post" # for submitting tutor form
  post "/profile" => "home#post" # for updating profile
  post "/request" => "request_tutor#post" # for submitting request form
  get "profile" => "home#profile"
  get "newroom" => "create_room#index"
  post "/newroom" => "create_room#post"
  # get "users/sign_in", to: "static_pages#mission", as: "mission"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
