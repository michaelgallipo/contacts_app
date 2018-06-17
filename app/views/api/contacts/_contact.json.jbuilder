json.id contact.id
json.first_name contact.first_name
json.last_name contact.last_name
json.middle_name contact.middle_name
json.city contact.city
json.email contact.email
json.cell_phone contact.cell_phone
json.bio contact.bio

json.formatted do 
  json.updated_at contact.friendly_updated_at
  json.full_name contact.full_name
  json.japan_phone contact.japan_phone
end

json.groups contact.groups
