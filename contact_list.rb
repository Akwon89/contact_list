require_relative 'contact'
require 'pry'
CSV.read('contacts.csv') 
# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  class << self

    def list_commands
      puts "Here is a list of commands:
            new - Create a new contact.
            list - List all contacts.
            show - Show a contact
            search - Search contacts."
    end
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
    def new
      puts "who would you like to add?"
      puts "name: ?"
      name = $stdin.gets.chomp
      puts "email: ?"
      email = $stdin.gets.chomp
      Contact.create(name,email)
      puts "contact #{name} with the email #{email} has been added!"
    end

    def list
      Contact.all
    end

    def show
      # id_arr =[]
      puts "whos id# are you looking for?"
      id = $stdin.gets.chomp
      if (found = Contact.find(id))
        puts found[0]
        puts found[1]
        puts found[2]
      else
        puts "id not found"
      end
      # CSV.read('contacts.csv').each{ |contact| id_arr = contact if id == contact[0].to_i }
      
    end
     

    def search
      puts"who are you searching for?"
      term = $stdin.gets.chomp
      if found = (Contact.search(term))
        puts found
        puts "----------------"
        puts "#{found.size} records found"
      else 
        puts "term not found"
      end
    end
  end
end


if ARGV[0] == "new"
  ContactList.new
elsif
  ARGV[0] == "list"
  ContactList.list
elsif
  ARGV[0] == "show"
  ContactList.show
elsif
  ARGV[0] == "search"
  ContactList.search
end
ContactList.list_commands