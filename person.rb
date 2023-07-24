class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name: 'Unknown', age: nil, parent_permission: true)
    @id = SecureRandom.uuid
    @name = name
    @age = age || 0
    @parent_permission = parent_permission
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def play_hooky
    '¯(ツ)/¯'
  end
end
