require 'csv'
require 'fastercsv'

class Contact
 
  @@contacts = []
  @id = 0

  attr_accessor :first_name, :last_name, :email, :id

  def initialize(first_name,last_name,email)
    @first_name = first_name
    @last_name = last_name
    @email = email
    # @id += 1
  end
 
  def to_s
    "#{self.id} - #{self.first_name} - #{self.last_name} - #{self.email}"
  end
 
  ## Class Methods
  class << self
    def create(first_name,last_name,email)
      contact = Contact.new(first_name,last_name,email)
      @@contacts << contact
      write('contacts.csv')
      contact      
    end
 
    def find(index_arg)
      # TODO: Will find and return contact by index
      result = nil
      @@contacts.each_with_index do |contact, index|
        contact.id = index
        if "#{index + 1}" == index_arg
          result = contact
        end
      end
      result
    end

    def find_by_email(email)
      result = nil
      @@contacts.each do |contact|
        if contact.email == email
          result = contact
        end
      end
      result
    end

    def search(query)
      query = query.upcase
      result = []
      @@contacts.each_with_index do |contact, index|
        if contact.first_name.upcase.index(query) || 
            contact.email.upcase.index(query) || 
            contact.last_name.upcase.index(query)
          contact.id = index
          result << contact
        end
      end
      result
    end
 
    def all
      @@contacts
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      
    end

    def read(csv_filename)
      temp_list = []
      temp_file = CSV.read(csv_filename).each do |line|
        temp_list << Contact.new(line[0], line[1], line[2])
      end
      @@contacts = temp_list
    end

    def write(csv_filename)
      CSV.open(csv_filename, 'wb') do |csv|
        @@contacts.each do |contact|
          csv << [contact.first_name, contact.last_name, contact.email]
        end
      end
    end
    
  end
 
end
