Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  resources :events do
    resources :artifacts
  end
end
