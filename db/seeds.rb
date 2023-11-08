# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# CLEAN DB
######################################################################
puts 'Cleaning the database...'
User.destroy_all
Contact.destroy_all

# USERS
######################################################################
puts 'Creating user...'
marcos = User.create!(
  {
    first_name: 'Marcos',
    last_name: 'Gabriel',
    password: '123456',
    email: 'marcos@birthday.com',
    telegram_id: ENV['MY_TELEGRAM_ID']
  }
)

felipe = User.create!(
  {
    first_name: 'Felipe',
    last_name: 'Souza',
    password: '123456',
    email: 'felipe@birthday.com',
    telegram_id: ENV['FELIPE_TELEGRAM']
  }
)

# CONTACTS
######################################################################
puts 'Creating some contacts...'
100.times do
  Contact.create!(
    {
      user: marcos,
      name: Faker::Name.name,
      birthday: Faker::Date.between(from: '2014-09-23', to: '2015-09-25')
    }
  )
end

puts 'Creating contacts with birthday today...'
5.times do
  Contact.create!(
    {
      user: marcos,
      name: Faker::Name.name,
      birthday: Date.today
    }
  )
end

2.times do
  Contact.create!(
    {
      user: felipe,
      name: Faker::Name.name,
      birthday: Date.today
    }
  )
end

#####################################################################
puts 'Finished!'
