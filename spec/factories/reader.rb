FactoryGirl.define do
  to_create { skip_create }

  factory :reader, class: Reader do
    sequence(:name) { |n| "Reader #{n}" }
    email "test@test.ru"
    city "Some sity"
    street "Some street"
    house "Some house"
    initialize_with { new(name, email, city, street, house) }
  end
end