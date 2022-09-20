class DashboardStatsController < ApplicationController
     def stats
        if admin?
            @users = User.all.order(created_at: :desc)
            @reservations = Reservation.includes(:user, :hall).all.order(created_at: :desc)
            @halls = Hall.includes(:reservations).all.order(created_at: :desc)
            generate_stats(@users,@reservations,@halls)
          else
            render json: { error: 'Not Allowed' }, status: :unauthorized
          end
    end

    private
    #Generate Stats from tables
    def generate_stats(users,reservations,halls)
     card_stats = generate_card_stats(users,reservations,halls)
     reservation_chart = generate_reservation_chart(reservations)
     halls_chart = generate_hall_chart(halls)
     recent_stats = generate_recent_stats(reservations,users)
        render json: { stats: {
            card_stats:card_stats,
            reservation_chart:reservation_chart,
            halls_chart:halls_chart,
            halls:halls,
            recent_stats:recent_stats
            }
        }
    end


    #Generate Stats for Cards Stats
    def generate_card_stats(users,reservations,halls)
        {
            total_reservations: reservations.size,
            total_users: users.size,
            total_halls: halls.size,
            total_pendings_reservations: reservations.select{|reservation| reservation.status === 'Pending' }.size
        }
    end

    #Generate Stats for Reservation Chart
    def generate_reservation_chart(reservations)
        pending = reservations.select{|reservation| reservation.status === 'Pending' }.size
        confrimed = reservations.select{|reservation| reservation.status === 'Confirmed' }.size
        refused = reservations.select{|reservation| reservation.status === 'Refused' }.size
        return {labels: ['Pending','Confirmed', 'Refused'],
        data:[pending,confrimed,refused]}
    end

    #Generate Stats for Hall Chart
    def generate_hall_chart(halls)
        halls_names = [] 
        total=[]
        pending=[]
        confirmed=[]
        halls.each {|hall| 
        halls_names<< hall.name 
        total<< hall.reservations.select{|reservation| reservation.status === 'Confirmed' }.size
        pending<< hall.reservations.select{|reservation| reservation.status === 'Confirmed' }.size
        confirmed<< hall.reservations.select{|reservation| reservation.status === 'Confirmed' }.size
        }
        {labels: halls_names,
        data:{total:total,pending:pending,confirmed:confirmed}}
    end
    
     #Generate Stats for Recent Users&RecentReservations
    def generate_recent_stats(reservations,users)
        recent_reservations = []
        reservations.limit(5).each {|reservation| 
        recent_reservations << {
            hall_name:reservation.hall.name,
            user_name:reservation.user.first_name,
            date:reservation.reserve_date,
            status:reservation.status}
        }
        {recent_users:users.select(:id, :first_name, :last_name, :email).limit(5),recent_reservations:recent_reservations}
    end
end
