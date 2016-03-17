require_relative 'contact'
require 'pry'
class ContactList

  class << self

    def list_commands
      puts "<--------------------------------------------x
            x--------------------------------x
              Here is a list of commands:
              new - Create a new contact.
              update (id#) - Update a contact.
              delete - Delete a contact.
              list - List all contacts.
              show - Show a contact
              search - Search contacts.
            x--------------------------------x
            x--------------------------------x"
    end

    def new
      puts "who would you like to add?"
      puts "name: ?"
      name = $stdin.gets.chomp
      puts "email: ?"
      email = $stdin.gets.chomp 
      Contact.create(name: name,email: email)
      puts "contact #{name} with the email #{email} has been added!"
    end

    def list
      puts "Here is a list of contacts..."
      contacts = Contact.all
      contacts.each { |contact| puts "#{ contact.id }: #{ contact.name } -- #{ contact.email }" }
    end

    def update(id)
      contact = Contact.find(id)
      puts "Enter new name: "
      new_name = $stdin.gets.chomp
      puts "Enter new email: "
      new_email = $stdin.gets.chomp
      contact.name = new_name
      contact.email = new_email
      contact.save    
    end

    def show
      begin
        print "Enter id to search: "
        id = $stdin.gets.chomp
        contact = Contact.find(id)
        if contact != nil
          puts "Displaying contact with #{id}..."
          puts "#{contact.id}: #{contact.name} -- #{contact.email}"
        else
          puts "not found"
        end
      rescue => e
        puts e.message
        show
      end
    end

    def delete
     begin
        puts "Enter id to delete: "
        id = $stdin.gets.chomp
        contact = Contact.find(id)
        if contact != nil
          puts "Deleting #{id}..."
          puts "#{contact.id}: #{contact.name} -- #{contact.email}"
          contact.destroy
          puts "DELETED!"
        else
          puts "not found"
        end
      rescue => e
        puts e.message
        show
      end
    end


    # def show
    #   puts "whos id# are you looking for?"
    #   id = $stdin.gets.chomp
    #   if (found = Contact.find(id))
    #     found.find(id).each { |contact| puts "Found!!! : #{contact["id"]}: #{contact["name"]} -- #{contact["email"]}" }
    #   else
    #     puts "id not found"
    #   end
    # end
     

    def search
      puts"who are you searching for?"
      term = $stdin.gets.chomp
      if found = (Contact.where(['name LIKE ?', "%#{term}%"]))
        # found = (Contact.exists?(['name LIKE ?', "%#{term}%"]))
        # binding.pry
        found.each { |contact| puts "#{contact.id} : #{contact.name} -- #{contact.email}"}
        puts "----------------"
        puts "#{found.length} records found"
      else 
        puts "term not found"
      end
    end

  end

end


if ARGV[0] == "new"
  ContactList.new
elsif 
  ARGV[0] == "update" and ARGV[1].to_i.is_a?Fixnum
  ContactList.update(ARGV[1])
elsif 
  ARGV[0] == "delete"
  ContactList.delete
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