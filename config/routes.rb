Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "request" => "request_tutor#index"
  # get "users/sign_in", to: "static_pages#mission", as: "mission"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
