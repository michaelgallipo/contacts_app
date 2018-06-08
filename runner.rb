require 'unirest'

puts "Enter desired action (Create/Update/Delete)"
user_action = gets.chomp.downcase

if user_action == "create"
  puts "Enter First Name:"
  first_name = gets.chomp
  puts "Enter Last Name:"
  last_name = gets.chomp
  puts "Enter City:"
  city = gets.chomp
  puts "Enter email Address:"
  email = gets.chomp
  puts "Enter Cell Phone Number:"
  cell_phone = gets.chomp

  params = {
    first_name: first_name,
    last_name: last_name,
    city: city,
    email: email,
    cell_phone: cell_phone
  }

  response = Unirest.post("http://localhost:3000/api/contacts", parameters: params).body

  puts JSON.pretty_generate(response)

elsif user_action == "update"
  puts "Enter Contact ID to edit:"
  contact_id = gets.chomp
  params = {
    city: "Rochester"
  }
  response = Unirest.patch("http://localhost:3000/api/contacts/#{contact_id}", parameters: params).body

  puts JSON.pretty_generate(response)

elsif user_action == "delete"
  puts "Enter Contact ID to delete:"
  contact_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/api/contacts/#{contact_id}").body

  puts JSON.pretty_generate(response)
else
end

