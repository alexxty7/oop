class Author
  attr_accessor :name, :biography

  def initialize(name, biography)
    @name = name
    @biography = biography
  end

  def to_s
  	"Author: #{@name}"
  end

  def ==(other)
    if other.is_a? Author
      @name == other.name
    else
      false
    end
  end
end
