Rails.application.routes.draw do
  root 'items#index'
  resources :items do
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
end
resources :credit_cards, only: [:new, :show, :destroy] do
  collection do
    post 'pay', to: 'credit_cards#pay'
  end
end
end