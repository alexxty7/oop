require 'spec_helper'

RSpec.describe Library do
	
	let(:library) { Library.new }
	let(:readers) { build_list(:reader, 10) }
	let(:books) { build_list(:book, 10) }
	let(:book) { books.first }
	let(:reader) { readers.first }

  let(:library_data) do
    10.times do|index| 
      library.add_book(books[index])
      library.order_book(books[index], readers[index])
    end
    3.times do |index|
      library.order_book(books[index], readers[index])
    end
  end

  describe '#add_book' do
    it 'should add book to library' do
      expect{library.add_book(book)}.to change(library.books, :count).by(1)
    end

    it 'should add author to library' do
      expect{library.add_book(book)}.to change(library.authors, :count).by(1)
    end
  end

  describe '#order_book' do
  	it 'return error if book is not in a library' do
      expect{library.order_book(book, reader)}.to raise_error(ArgumentError)
    end

    it 'add new order' do
    	library_data
      expect{library.order_book(book, reader)}.to change(library.orders, :count).by(1)
    end
  end

  describe '#who_often_take_book' do
    it 'return reader who often order book' do
    	library_data
      library.order_book(book, reader)
      expect(library.who_often_take_book(book).to_s).to eq("Reader: #{reader.name} / #{reader.email}")
    end

    it 'raise error if book is not in a library' do
      expect{library.who_often_take_book(book)}.to raise_error(ArgumentError)
    end
  end

  describe '#most_popular_book' do
    it 'return most ordered book' do
    	library_data
      library.order_book(book, reader)
      expect(library.most_popular_book.to_s).to eq("Book: #{book.title} / #{book.author}")
    end
    it 'return message if orders empty' do
      expect(library.most_popular_book).to eq("There are not orders in a library")
    end
  end

  describe '#count_readers_popular_books' do
    it 'return readers who ordered 3 most popular books' do
    	library_data
      expect(library.count_readers_popular_books).to eq(3)
    end
    it 'return message if orders empty' do
      expect(library.count_readers_popular_books).to eq("There are not orders in a library")
    end
  end

  describe '#save_to_file and .load_from_file' do
    it 'save library to file and load from' do
      allow(library).to receive(:puts)
    	library_data
      library.save_to_file

      expect(Library.load_from_file).to eq(library)
    end
  end
end