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
   #Halls C.R.U.D Routes
    get "/admin/halls", to: "halls#halls_list"
    patch "/admin/halls", to: "halls#update_hall"
    delete "/admin/halls", to: "halls#delete_hall"
    post "/admin/halls", to: "halls#add_hall"
end
