Rails.application.routes.draw do
  devise_for :users

  resources :movies do
    member do
      post :favorite
    end
  end



  namespace :account do
    resources :groups
    resources :posts
  end

  root "movies#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
