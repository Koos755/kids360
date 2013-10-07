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

parents.each do |parent|
  Parent.create(parent)
end

puts "There are now #{Parent.count} parents in the database"
