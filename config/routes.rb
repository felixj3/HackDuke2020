Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  get "request" => "request_tutor#index"
  get "assist" => "become_tutor#index"
  # get "users/sign_in", to: "static_pages#mission", as: "mission"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
