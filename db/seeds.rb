# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'patience',
             email: 'patience@bsc.bsc',
             password: 'password',
             password_confirmation: 'password',
             activated: true,
             activated_at: Time.now,
             admin: true,
             bsc: true)

('a'..'cv').each do |postfix|
  name = "bscuser#{postfix}"
  email = "bscuser#{postfix}@bsc.bsc"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.now,
               admin: false)
end
