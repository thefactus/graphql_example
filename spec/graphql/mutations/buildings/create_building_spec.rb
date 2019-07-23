# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Buildings
    RSpec.describe Create, type: :request do
      describe '.resolve' do
        it 'creates a building' do
          expect do
            post '/graphql', params: { query: query }
          end.to change { Building.count }.by(1)
        end

        it 'returns a building' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['createBuilding']

          expect(data['building']).to include(
            'id' => be_present,
            'name' => 'Building graphql',
            'uprn' => '1234'
          )
        end
      end

      def query
        <<~GQL
          mutation {
            createBuilding(input: {
              name: "Building graphql"
              uprn: "1234"
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
