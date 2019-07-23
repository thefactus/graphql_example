class Building < ApplicationRecord
  validates_presence_of :name, :uprn
end
