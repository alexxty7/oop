FactoryGirl.define do
  to_create { skip_create }

  factory :book, class: Book do
    sequence(:title) { |n| "Dark Tower #{n}" }
    author
    initialize_with { new(title, author) }
  end
end