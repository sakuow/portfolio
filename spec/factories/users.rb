FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    # profile_image_id { Rack::Test::UploadedFile.new(file.join(Rails.root, 'public/images/.jpg')) }
    password { 'test12345' }
    password_confirmation { password }
  end
end

