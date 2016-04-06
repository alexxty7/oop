require_relative 'book'
require_relative 'author'
require_relative 'reader'
require_relative 'order'
require 'yaml'

class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize
    @books = []
    @orders = []
    @readers = []
    @authors = []
  end

  def add_book(book)
    @books << book unless @books.include? book
    @authors << book.author unless @authors.include? book.author
  end

  def order_book(book, reader)
    raise ArgumentError, "This book is not in the library" unless @books.include? book
    @readers << reader unless @readers.include? reader
    @orders << Order.new(book, reader)
  end

  def who_often_take_book(book)
    raise ArgumentError, "This book is not in the library" unless @books.include? book
    book_readers = @orders.select { |order| order.book == book }.map!(&:reader)
    sort_and_count(book_readers)
  end

  def most_popular_book
    return "There are not orders in a library" if @orders.empty?
    books = @orders.map!(&:book)
    sort_and_count(books)
  end

  def count_readers_popular_books
    return "There are not orders in a library" if @orders.empty?
    @orders.group_by(&:book).max_by(3) { |book, order| order.size }
           .map {|k, v| v[0].reader}.uniq.count
  end

  def self.load_from_file
    YAML.load(File.read('./temp.txt'))
  end

  def save_to_file
    File.open('./temp.txt', 'w') {|f| f.write(YAML.dump(self)) }
    puts "Library saved to file"
  end

  def ==(other)
    if other.is_a? Library
      @books == other.books && @orders == other.orders
    else
      false
    end
  end

  private

  def sort_and_count(item)
    item.each_with_object(Hash.new(0)) { |key, hash| hash[key] +=1; hash }
        .sort_by { |_book, value| value }.last[0]
  end
end
