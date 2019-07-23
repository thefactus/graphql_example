FactoryBot.define do
  factory :building do
    sequence(:name) { |n| "Building #{n}" }
    sequence(:uprn) { |n| n }
  end
end
