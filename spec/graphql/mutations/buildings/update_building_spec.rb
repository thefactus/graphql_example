# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Buildings
    RSpec.describe Update, type: :request do
      describe '.resolve' do
        it 'update a building' do
          building = Building.create(name: 'Building graphql',
                                     uprn: '1234')

          new_name = 'new building name'
          new_uprn = '5555'
          post '/graphql', params: { query: query(building.id,
                                                  new_name,
                                                  new_uprn) }

          json = JSON.parse(response.body)
          data = json['data']['updateBuilding']

          expect(data['building']).to include(
            'name' => new_name,
            'uprn' => new_uprn
          )
        end
      end

      def query(id, new_name, new_uprn)
        <<~GQL
          mutation {
            updateBuilding(input: {
              id: #{id}
              name: "#{new_name}"
              uprn: "#{new_uprn}"
            }) {
              building {
                id
                name
                uprn
              }
              errors
            }
          }
        GQL
      end
    end
  end
end
