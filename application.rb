require_relative 'contact'
require_relative 'contact_database'

class Application

def puts_menu
  puts "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"
end

Contact.read('contacts.csv')

arguments = ARGV.clone
ARGV.clear

command = nil
if (!arguments.empty?)
  command = arguments[0]
end

if command.nil? || command == 'help'
  puts_menu
elsif command == "new"
  puts "Please provide the email of your new contact"
  email = gets.chomp
  if Contact.find_by_email(email) != nil
    puts "There is a pre-existing contact with that email"
    exit(1)
  end
  puts "Please provide the first name of your new contact"
  first_name = gets.chomp
  puts "Please provide the last name of your new contact"
  last_name = gets.chomp
  contact = Contact.create(first_name,last_name,email)
  puts "Created #{contact}"
elsif command == "list"
  Contact.all.each_with_index do |contact, index|
    puts "#{index + 1}: #{contact}"
  end
elsif command == "show"
  contact = Contact.find(arguments[1])
  puts "#{contact.id + 1}: #{contact}"
elsif command == "find"
  contacts = Contact.search(arguments[1])
  contacts.each do |contact|
    puts "#{contact.id + 1}: #{contact}"
  end
end


end