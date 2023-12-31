require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

class App
  attr_reader :books, :person, :rentals, :classroom

  def initialize
    @books = []
    @person = []
    @rentals = []
  end

  def list_all_books()
    puts 'All Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people()
    @person.each do |person|
      puts "[#{person.class}] Name: #{person.name}, age: #{person.age}"

      if person.instance_of?(Teacher)
        puts "Specialization: [#{person.specialization}]"
      else
        puts "Permission: #{person.parent_permission}"
      end
    end
  end

  def create_person()
    puts 'Do you want to create a student (1) or teacher (2) [Input the number]:'
    is_student = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp.to_i

    case is_student
    when 1
      print 'Has parent permission [Y/N]:'
      permission = gets.chomp.downcase == 'y'
      student = Student.new(1, age, permission, name)
      @person << student

    when 2
      print 'Specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      @person << teacher
    end

    puts 'Person created successfully.'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully.'
  end

  def create_rental
    puts 'select book by number'
    @books.each_with_index do |book, index|
      puts "#{index} - Title: #{book.title}, Author: #{book.author}"
    end

    book_index = gets.chomp.to_i

    puts 'select person from the following list by numbers (not id)'
    @person.each_with_index do |person, index|
      puts "#{index} - [#{person.class}], Name: #{person.name}, ID #{person.id}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i
    puts 'Enter date:'
    date = gets.chomp

    rental = Rental.new(date, @books[book_index], @person[person_index])
    @rentals << rental
    puts 'Rental created successfully.'
  end

  def list_rentals_for_person
    puts 'all id'
    @rentals.each do |rental|
      puts "ID of person: #{rental.person.id}"
    end
    puts 'select id'
    id = gets.chomp.to_i

    puts 'All Rentals for this id:'
    @rentals.each do |rental|
      if rental.person.id == id
        puts "Title: #{rental.book.title}, Author: #{rental.book.author}, Date: #{rental.date}"

      else
        puts 'rental not found'
      end
    end
  end
end
