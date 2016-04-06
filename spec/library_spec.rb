require 'spec_helper'

RSpec.describe Library do
	
	let(:library) { Library.new }
	let(:readers) { build_list(:reader, 10) }
	let(:books) { build_list(:book, 10) }
	let(:book) { books.first }
	let(:reader) { readers.first }

	context 'whithout error' do
		before do
			10.times do|index| 
				library.add_book(books[index])
				library.order_book(books[index], readers[index])
			end
			3.times do |index|
				library.order_book(books[index], readers[index])
			end
		end

		it 'return most_popular_book' do
			library.order_book(book, reader)
			expect(library.most_popular_book.to_s).to eq("Book: #{book.title} / #{book.author}")
		end

		it 'return who_often_take_book' do
			library.order_book(book, reader)
			expect(library.who_often_take_book(book).to_s).to eq("Reader: #{reader.name} / #{reader.email}")
		end

		it 'return count_readers_popular_books' do
			expect(library.count_readers_popular_books).to eq(3)
		end

		it 'ordered book' do
			expect{library.order_book(book, reader)}.to change(library.orders, :count).by(1)
		end

		it 'save library to file and load from' do
			library.save_to_file
			new_library = Library.load_from_file

			expect(new_library).to eq(library)
		end

		context '#add_book' do
			it 'should add book to library' do
				new_book = build(:book)
				expect{library.add_book(new_book)}.to change(library.books, :count).by(1)
			end

			it 'should add author to library' do
				new_author = build(:author, name: "Paolo")
				new_book = build(:book, author: new_author)
				expect{library.add_book(new_book)}.to change(library.authors, :count).by(1)
			end
		end

	end

	context 'return error' do
		it '#who_often_take_book if book is not in the library' do
			expect{library.who_often_take_book(book)}.to raise_error(ArgumentError)
		end

		it '#order_book if book is not in the library' do
			expect{library.order_book(book, reader)}.to raise_error(ArgumentError)
		end

		it '#most_popular_book return message if orders empty' do
			expect(library.most_popular_book).to eq("There are not orders in a library")
		end

		it '#count_readers_popular_books return message if orders empty' do
			expect(library.count_readers_popular_books).to eq("There are not orders in a library")
		end
	end
end