# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Building, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :uprn }
  end
end
