class DashboardStatsController < ApplicationController
     def stats
        if admin?
            @users = User.all.order(created_at: :desc)
            @reservations = Reservation.all.order(created_at: :desc)
            @halls = Hall.all.order(created_at: :desc)
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
        render json: { stats: {
            card_stats:card_stats,
            reservation_chart:reservation_chart,
            halls_chart:halls_chart,
            }
        }
    end


    #Generate Stats for Cards Stats
    def generate_card_stats(users,reservations,halls)
        {
            total_reservations: reservations.length(),
            total_users: users.length(),
            total_halls: halls.length(),
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

    def generate_hall_chart(halls)
        'okay'
end
