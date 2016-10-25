Rails.application.routes.draw do
  resources :lists do
    resources :tasks do
      member do
        patch :complete
      end
    end
  end

  root 'static_pages#index'
end
