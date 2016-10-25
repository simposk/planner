Rails.application.routes.draw do
  devise_for :users
  resources :lists do
    resources :tasks do
      member do
        patch :complete
      end
    end
  end

  root 'static_pages#index'
end
