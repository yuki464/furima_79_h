Rails.application.routes.draw do
  root 'items#index'
  resources :items do
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
end
resources :credit_cards, only: [:index,:new, :show, :destroy] do
  member do
    post 'pay', to: 'credit_cards#pay'
  end
end
end