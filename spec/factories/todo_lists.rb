# frozen_string_literal: true

FactoryBot.define do
  factory :todo_list do
    user
    title { Faker::Lorem.sentence }
  end
end
