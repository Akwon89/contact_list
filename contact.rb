require 'pg'

class Contact
  
  attr_accessor :id, :name, :email
  
 
  def initialize(name, email)
    @name = name
    @email = email
  end
  
  def save
    if self.id
      # => update the record
      res = self.class.connection.exec_params('
        UPDATE contacts SET 
        name = $1, email = $2 
        WHERE id = $3::int RETURNING *
      ', [self.name, self.email, self.id])
    else
      # => insert a new record
      res = self.class.connection.exec_params("
          INSERT INTO contacts (name, email) 
          VALUES($1, $2) RETURNING id", [self.name, self.email])
      # self.id = res.first["id"]
    end
  end

  def destroy
    self.class.connection.exec_params('DELETE FROM contacts WHERE id = $1::int', [self.id])
  end

  class << self

    def connection
      PG.connect(
      host: 'localhost',
      dbname: 'contacts',
      user: 'development',
      password: 'development'
      )
    end

    def all
      self.connection.exec("SELECT * FROM contacts")
    end

    def instantiate_contact_from_hash(contact)
      # contact = Contact.new
      # contact.id = hash["id"]
      # contact.name = hash["name"]
      # contact.email = hash["email"]
      # contact
      c = self.new(contact["name"], contact["email"])
      c.id = contact["id"]
      c
    end

    def first
      res = connection.exec_params("SELECT * FROM contacts ORDER BY id ASC LIMIT 1")
      # instantiate_contact_from_hash(res.first)
    end

    def last
      res = connection.exec_params("SELECT * FROM contacts ORDER BY id DESC LIMIT 1")
      # instantiate_contact_from_hash(res.first)
    end

    def create(name, email)
      contact = Contact.new(name, email)
      contact.save
      contact
    end
    
    def find(id)
      res = self.connection.exec_params('SELECT * FROM contacts WHERE id = $1::int', [id]).first
      instantiate_contact_from_hash(res)
    end

    def search(term)
     search_string = '%' + term + '%'
     res = self.connection.exec_params('SELECT * FROM contacts WHERE name LIKE $1 OR email LIKE $2', [search_string, search_string]).to_a
     res.map { |contact| instantiate_contact_from_hash(contact) }
    end

  end

end


# Contact.all

