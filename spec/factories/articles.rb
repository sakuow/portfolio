FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:30) }
    # images_files { Faker::
  end
end