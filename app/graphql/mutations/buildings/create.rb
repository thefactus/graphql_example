# frozen_string_literal: true

class Mutations::Buildings::Create < Mutations::BaseMutation
  argument :name, String, required: true
  argument :uprn, String, required: true

  field :building, Types::BuildingType, null: false
  field :errors, [String], null: false

  def resolve(name:, uprn:)
    building = Building.new(name: name, uprn: uprn)
    if building.save
      { building: building,
        errors: [] }
    else
      { building: nil,
        errors: [building.errors.full_messages] }
    end
  end
end
