class Reader
  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def to_s
  	"Reader: #{@name} / #{@email}"
  end

  def ==(other)
    if other.is_a? Reader
      @name == other.name && @email == other.email
    else
      false
    end
  end
end
