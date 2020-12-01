# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    name { FFaker::Name.unique.name }
    track_num { FFaker::Random.rand(1..99_999) }
    genre { FFaker::Book.genre }
    duration { FFaker::Random.rand(1..100) }
    album { create(:album) }

    trait :featured do
      featured { true }
      feature_text { FFaker::DizzleIpsum.paragraph }
      image { Rack::Test::UploadedFile.new('public/sample_image.jpeg', 'image/jpeg') }
    end
  end
end
