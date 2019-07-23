# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_building, mutation: Mutations::Buildings::Create
    field :update_building, mutation: Mutations::Buildings::Update
  end
end
