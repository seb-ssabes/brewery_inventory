Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show] do
    resources :items
  end

  resources :items do
    get :toggle_sort, on: :collection
  end
end
