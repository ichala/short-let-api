require 'swagger_helper'

RSpec.describe 'dashboard_stats', type: :request do

  path '/admin/stats' do

    get('stats dashboard_stat') do
      tags "Dashboard"
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
