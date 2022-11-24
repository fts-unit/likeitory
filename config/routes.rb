Rails.application.routes.draw do

  post "follows/:user_id/create" => "follows#create"
  post "follows/:user_id/destroy" => "follows#destroy"

  post 'likers/:id/update' => 'likers#update'
  get 'likers/:id/edit' => 'likers#edit'
  get 'likers/:id' => 'likers#show'

  post "likestories/:post_id/create" => "likestories#create"
  post "likestories/:post_id/destroy" => "likestories#destroy"
  
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post 'users/:id/update' => 'users#update'
  get 'users/:id/edit' => 'users#edit'
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get 'users/index'
  get 'users/:id' => 'users#show'
  get "users/:id/likes" => "users#likes"
  get "users/:id/likers" => "users#likers"
  get "users/:id/followers" => "users#followers"
  get "users/:id/followings" => "users#followings"

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  get '/' => 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
