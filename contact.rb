require 'csv'
require'pry'
CSV.read('contacts.csv') 

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact
  
  attr_accessor :name, :email
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      #total_contacts = []
      CSV.read('contacts.csv').each{ |contact| puts "#{contact[0]} #{contact[1]} #{contact[2]}"} 
      puts "--------------------------------------"
      puts "#{CSV.read('contacts.csv').size} records total"
      #CSV.read('contacts.csv').each{ |contact| total_contacts << contact}
      #total_contacts_count = total_contacts.length
      #puts "#{total_contacts_count} records total"

    end


    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      id_num = CSV.read('contacts.csv').size + 1
      CSV.open('contacts.csv', 'a+'){ |csv| csv << [id_num, name, email] }
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      # contacts = []
      # CSV.read('contacts.csv').each{ |contact| contacts << contact }
      # id = contacts[0]
      # p id
      id_arr = nil
      CSV.read('contacts.csv').each{ |contact| id_arr = contact if id == contact[0] }
      id_arr
        # if id_arr == []
        #   puts "id not found"
        # else
        #   id_arr
        #   puts id_arr[0]
        #   puts id_arr[1]
        #   puts id_arr[2]
        # end
      # CSV.read('contacts.csv').find { |contact| contact[0] == id }
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
       search_array = []
      CSV.read('contacts.csv').select { |contact| search_array << contact if contact.include?(term)}
      search_array

      # if search_array.select!{ |list| list.include?(term) }
      #   search_array.size
      #   puts search_array
      #   puts "----------------"
      #   puts "#{search_array.size} records found"
      # else 
      #   puts "term not found"
      # end
    end

  end

end

# p Contact.search("Andrew")
# binding.pry