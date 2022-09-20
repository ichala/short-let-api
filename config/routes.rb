Rails.application.routes.draw do
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
    delete "/user/reservations", to: "reservations#delete_reservation"

  #Admin Routes 
   #Pending Reservations Routes
    get "/admin/requests/pending", to: "reservations#pending_reservation_admin"
    patch "/admin/requests/pending", to: "reservations#handle_pending_reservation_admin"
   #Admin users CRUD Routes
    get "/admin/users", to: "users#get_users"
    patch "/admin/user/update", to: "users#update_user_info"
    delete "/admin/user/destroy", to: "users#destroy"
end
