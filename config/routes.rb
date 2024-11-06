Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show] do
    resources :items
  end

  resources :items do
    collection do
      get :toggle_sort
    end
  end
end
