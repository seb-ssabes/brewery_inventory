Rails.application.routes.draw do
  get 'items/index'
  get 'items/show'
  get 'items/new'
  get 'items/create'
  get 'items/edit'
  get 'items/update'
  get 'items/destroy'

  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/destroy'

  root 'categories#index'
  resources :categories do
    resources :items
  end
end
