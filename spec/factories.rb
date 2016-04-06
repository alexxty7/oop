FactoryGirl.define do
	to_create { skip_create }

	factory :author, class: Author do
		name "Stiven King"
		biography "Lorem ipsum dolor sit amet."
		initialize_with { new(name, biography) }
	end

	factory :book, class: Book do
		sequence(:title) { |n| "Dark Tower #{n}" }
		author
		initialize_with { new(title, author) }
	end

	factory :reader, class: Reader do
		sequence(:name) { |n| "Reader #{n}" }
		email "test@test.ru"
		city "Some sity"
		street "Some street"
		house "Some house"
		initialize_with { new(name, email, city, street, house) }
	end
end