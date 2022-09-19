Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  #Public Routes

  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  get "/authorized", to: "sessions#show"
  post "/reservation", to: "reservations#create"

  #Admin Routes 
   #Pending Reservations Routes
    get "/admin/requests/pending", to: "reservations#pending_reservation_admin"
    patch "/admin/requests/pending", to: "reservations#handle_pending_reservation_admin"
    #my reservations Routes
    get "/user/reservations", to: "reservations#my_reservations"
end
