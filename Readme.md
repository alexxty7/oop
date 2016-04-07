# Library
* Book: title, author
* Order: book, reader, date
* Reader: name, email, city, street, house
* Author: name, biography
* Library: books, orders, readers, authors

# Write program that determines:
* Who often takes the book
* What is the most popular book
* How many people ordered one of the three most popular books
* Save all Library data to file(s)
* Get all Library data from file(s)

# Using

stiven = Author.new("Stiven King", "")
book_1 = Book.new("Dark Tower", stiven)
book_2 = Book.new("Dark Tower 1", stiven)
book_3 = Book.new("Dark Tower 2", stiven)

reader_1 = Reader.new("Reader_1", "test1@test.ru", "", "", "")
reader_2 = Reader.new("Reader_2", "test2@test.ru", "", "", "")
reader_3 = Reader.new("Reader_3", "test1@test.ru", "", "", "")
reader_4 = Reader.new("Reader_4", "test1@test.ru", "", "", "")

library = Library.new
library.add_book(book_1)
library.add_book(book_2)
library.add_book(book_3)

3.times { library.order_book(book_1, reader_1) }

library.order_book(book_1, reader_2)
library.order_book(book_1, reader_3)
library.order_book(book_1, reader_4)

library.order_book(book_2, reader_1)
library.order_book(book_3, reader_2)
library.order_book(book_2, reader_3)
library.order_book(book_3, reader_4)

library.who_often_take_book(book_1)
library.most_popular_book
library.count_readers_popular_books

library.save_to_file
library = Library.load_from_file
library.most_popular_book