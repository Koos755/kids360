# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

parents = [{first_name: "Demarcus", last_name: "Bowser", phone_number: "9012894290", email: "bowser.dr@gmail.com", email_confirmed: true, address: "1381 S Willett St", city: "Memphis", state: "TN", zip: "38106", password: "MyPassword", password_confirmation: "MyPassword" },
           {first_name: "Audrey", last_name: "Jones", phone_number: "9015684006", email: "audreypjones@gmail.com", email_confirmed: true, address: "1005 Idlewild", city: "Memphis", state: "TN", zip: "38107", password: "pw4apj", password_confirmation: "pw4apj" },
           {first_name: "Jim", last_name: "Smith", phone_number: "9012680070", email: "mrsmithsemail@gmail.com", email_confirmed: true, address: "2001 New St", city: "Memphis", state: "TN", zip: "38111", password: "MrSmithsemail", password_confirmation: "MrSmithsemail" }]

children = [{parent_id: 1, first_name: "Christopher", last_name: "Bowser", email: "christopher@bowser.com", phone_number: "3128451798"},
            {parent_id: 1, first_name:"Susan", last_name: "Bowser", email: "susan@bowser.com", phone_number:"3126789458"},
            {parent_id: 1, first_name:"Siri", last_name: "Bowser", email: "siri@bowser.com", phone_number: "3126798908"}]

organizations = [{name: "Facebook", email: "info@facebook.com"}, {name: "Twitter", email: "info@twitter.com"}, {name: "CTA", email: "info@cta.com"}, {name: "Harvard", email: "info@harvard.com"}]

authorizations = [{organization_id: 1, child_id: 1},
                  {organization_id: 2, child_id: 1},
                  {organization_id: 3, child_id: 1},
                  {organization_id: 1, child_id: 2},
                  {organization_id: 2, child_id: 2},
                  {organization_id: 3, child_id: 3}]

parents.each do |parent|
  Parent.create(parent)
end

children.each do |child|
 Child.create(child)
end

organizations.each do |organization|
  Organization.create(organization)
end

authorizations.each do |authorization|
  Authorization.create(authorization)
end

puts "There are now #{Parent.count} parents in the database"
puts "There are now #{Child.count} children in the database"
puts "There are now #{Organization.count} organizations in the database"
puts "There are now #{Authorization.count} authorization in the database"




