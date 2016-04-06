class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date = Time.now)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "Book: #{@book.title} ordered by #{@reader.name}"
  end

  def ==(other)
    if other.is_a? Order
      @book == other.book && @reader == other.reader && @date == other.date
    else
      false
    end
  end
end
