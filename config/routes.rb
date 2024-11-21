Rails.application.routes.draw do
  root 'home#index'

  namespace :calculators do
    get '/', to: 'calculators#index', as: :index
    get 'abv', to: 'calculators#abv', as: :abv
    get 'density_correction', to: 'calculators#density_correction', as: :density_correction
    post 'calculate_abv', to: 'calculators#calculate_abv', as: :calculate_abv
    post 'calculate_density_correction', to: 'calculators#calculate_density_correction', as: :calculate_density_correction
  end

  namespace :hops do
    get 'search', to: 'hops#index'
    get 'api_search', to: 'hops#api_search'
    get 'api_detail', to: 'hops#api_detail'
  end

  resources :categories, only: [:index, :show] do
    resources :items
  end

  resources :items do
    get :toggle_sort, on: :collection
  end
end
