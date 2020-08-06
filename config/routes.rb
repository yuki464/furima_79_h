Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profiles'
    post 'profiles', to: 'users/registrations#create_profiles'
  end
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :items do
    collection do
      get "done",to:"items#done"
      post "pay", to: "items#pay"
      get "buy", to: "items#buy"
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    # 本来はメンバーでやりたのだが現状はidがないのでコレクションでビューを確認
    # member do
    #   get "buy", to: "items#buy"
    # end
    resources :cards, only: [:new, :show, :destroy] do
      collection do
        post 'pay', to: 'cards#pay'
      end
    end
  end
end

