# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    year { FFaker::Time.datetime.year }
    name { FFaker::Name.name }
  end
end
