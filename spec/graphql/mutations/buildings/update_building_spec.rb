# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Buildings
    RSpec.describe Update, type: :request do
      let(:building) do
        Building.create(name: 'Building graphql',
                        uprn: '1234')
      end

      describe '.resolve' do
        context 'when the update is valid' do
          it 'update a building' do
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

        context 'when does not provide a required argument' do
          it 'return an required error message' do
            new_name = 'new name'
            post '/graphql', params: { query: query_missing_argument(building.id,
                                                                     new_name) }

            json = JSON.parse(response.body)
            message = json['errors'][0]['message']

            expect(message).to include 'Argument \'uprn\' on InputObject \'UpdateInput\' is required. Expected type String!'
          end
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

      def query_missing_argument(id, new_name)
        <<~GQL
          mutation {
            updateBuilding(input: {
              id: #{id}
              name: "#{new_name}"
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
