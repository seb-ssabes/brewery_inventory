Rails.application.routes.draw do
  root 'home#index'

  get 'calculators/index', to: 'calculators#index'
  get 'calculators/abv', to: 'calculators#abv'
  get 'calculators/density_correction', to: 'calculators#density_correction'
  post 'calculators/calculate_abv', to: 'calculators#calculate_abv'
  post 'calculators/calculate_density_correction', to: 'calculators#calculate_density_correction'


  get 'hops/search', to: 'hops#index'
  get 'hops/api_search', to: 'hops#api_search'
  get 'hops/api_detail', to: 'hops#api_detail'


  resources :categories, only: [:index, :show] do
    resources :items
  end

  resources :items do
    get :toggle_sort, on: :collection
  end
end
