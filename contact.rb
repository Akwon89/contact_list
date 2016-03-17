require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  username: 'development',
  password: 'development',
  database: 'contacts'
)

# ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

class Contact < ActiveRecord::Base
  
end


