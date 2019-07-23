# frozen_string_literal: true

class Mutations::Buildings::Update < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: true
  argument :uprn, String, required: true

  field :building, Types::BuildingType, null: false
  field :errors, [String], null: false

  def resolve(id:, name:, uprn:)
    building = Building.find(id)

    if building.update(name: name, uprn: uprn)
      { building: building,
        errors: [] }
    else
      { building: nil,
        errors: [building.errors.full_messages] }
    end
  end
end
