FactoryGirl.define do
  to_create { skip_create }

  factory :author, class: Author do
    name "Stiven King"
    biography "Lorem ipsum dolor sit amet."
    initialize_with { new(name, biography) }
  end
end