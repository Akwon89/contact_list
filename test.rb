require 'csv'

contacts = CSV.foreach('contacts.csv') do |x|
  puts x.inspect
end

p contacts