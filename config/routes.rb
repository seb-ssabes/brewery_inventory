Rails.application.routes.draw do
  root 'categories#index'
  get 'hops/search', to: 'hops#index'
  get 'hops/api_search', to: 'hops#api_search'

  resources :categories, only: [:index, :show] do
    resources :items
  end

  resources :items do
    get :toggle_sort, on: :collection
  end
end
