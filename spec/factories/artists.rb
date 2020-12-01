# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    biography { FFaker::DizzleIpsum.paragraph }
    name { FFaker::Name.name }
  end
end
