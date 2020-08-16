class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value) } #assign values to hash at init
    @@all << self # collection of students created will be stored in this class variable 
  end

  def self.create_from_collection(students_array)
    students_array.each do |name| # goes through each student in array
      student = Student.new(name) #creates each new Student 
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |key, value| self.send(("#{key}="), value) }#assign values to hash 
  end

  def self.all #addes new students to @@all variable
    @@all
  end
end

