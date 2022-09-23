require 'faker'

admin = User.create!(first_name:"Admin",last_name:"Admin",role:"admin",email:"admin@admin.com",password:"admin123")
admin.hall.create!(name:Faker::Company.name,capacity:Faker::Number.between(from: 1, to: 100),cost:Faker::Number.between(from: 1, to: 100),description:Faker::Quote.matz,image:Faker::Company.logo)
10.times do 
 user = User.create(first_name:Faker::Name.name,last_name:Faker::Name.name,role: %w[user admin].sample ,email:Faker::Internet.email,password:"test")
 if user.role == 'admin'
    user.hall.create!(name:Faker::Company.name,capacity:Faker::Number.between(from: 1, to: 100),cost:Faker::Number.between(from: 1, to: 100),description:Faker::Quote.matz,image:Faker::Company.logo)
 end  
 reservation = user.reservations.create!(hall_id:1,reserve_date:Faker::Date.forward(days: 100),status:"Confirmed")
 admin.notifier.create!(recipient_id:user.id,admin_id:admin,text:Faker::Quote.matz,reserve_id:reservation.id)
end
