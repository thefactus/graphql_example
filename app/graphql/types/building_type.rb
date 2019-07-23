# frozen_string_literal: true

module Types
  class BuildingType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :uprn, String, null: false
  end
end
