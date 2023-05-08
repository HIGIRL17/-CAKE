Rails.application.routes.draw do

  root :to =>"public/homes#top"
  get '/about' => 'public/homes#about'


  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :public do
  end

  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: :my_page
    get 'customers/infomation/edit' => 'customers#edit', as: :edit_infomation
    patch 'customers/infomation/edit' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: :unsubscribe
    patch 'customers/withdraw' => 'customers#withdraw', as: :withdraw
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index,:create,:update,:destroy]
    delete 'cart_items' => 'cart_items#destroy_all' , as: 'all_destroy'
    #get  "orders/comfirm" => redirect("orders/new")
    post '/orders/comfirm' => 'orders#comfirm'
    get '/orders/complete' => 'orders#complete'
    resources :orders, only: [:index, :show, :new, :create]
  end

  namespace :admin do
      root to: 'homes#top'
      resources :genres, only: [:index, :create, :edit, :update]
      resources :items, only:[:index, :new, :show, :edit, :update, :create]
      resources :customers, only: [:index, :show, :edit, :update]
      resources :orders, only: [:show, :update]
      resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end