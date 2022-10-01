Rails.application.routes.draw do
  devise_for :order_details
  devise_for :orders
  devise_for :cart_items
  devise_for :genres
  devise_for :items
  devise_for :addresses
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
