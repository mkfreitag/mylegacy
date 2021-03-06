FactoryBot.define do


  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :event do
    title { "hello" }
    date { Date.new()}
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') }
    association :user
  end

  factory :artifact do
    comment { "hello" }
    association :user
    video { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'small.mp4').to_s, 'video/mp4') }
  end
end