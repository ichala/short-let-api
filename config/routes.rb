Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #Public Routes

  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  get "/authorized", to: "sessions#show"

  #User Routes
  post "user/reservation", to: "reservations#create"
  #my reservations Routes
  get "/user/reservations", to: "reservations#my_reservations"
  #delete reservation
  post "/reservation/check_date", to: "reservations#available_halls"
  delete "/user/reservations", to: "reservations#delete_reservation"

  # Update profile route
  patch "/profile/update", to: "profile#update"

  #Admin Routes 
  #All reservations
  get "/admin/reservations", to: "reservations#all_reservations"
  #Pending Reservations Routes
  get "/admin/requests/pending", to: "reservations#pending_reservation_admin"
  patch "/admin/requests/pending", to: "reservations#handle_pending_reservation_admin"
  #Halls C.R.U.D Routes
  get "/halls", to: "halls#halls_list"
  patch "/admin/halls", to: "halls#update_hall"
  delete "/admin/halls/:id", to: "halls#delete_hall"
  post "/admin/halls", to: "halls#add_hall"
  #Dashboard Stats Route
  get "admin/stats", to: "dashboard_stats#stats"
  #Admin users CRUD Routes
  get "/admin/users", to: "users#all_users"
  patch "/admin/user/update", to: "users#update_user_info"
  delete "/admin/user/destroy", to: "users#destroy"
end
