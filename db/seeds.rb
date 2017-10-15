# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

user_setup = [
  ["lorgana", "leia_organa.jpg", Faker::StarWars],
  ["chewie", "chewie.jpg", Faker::StarWars],
  ["baddad", "darth_vader.jpg", Faker::StarWars],
  ["iamlordvoldemort", "tom_riddle.png", Faker::HarryPotter],
  ["hpotter", "harry_potter.jpg", Faker::HarryPotter],
  ["hgranger", "hermione_granger.jpg", Faker::HarryPotter],
  ["bbaggins", "bilbo_baggins.jpg", Faker::Hobbit],
  ["precious", "gollum.jpg", Faker::Hobbit],
  ["hsimpson", "homer_simpson.jpg", Faker::Simpsons],
  ["msimpson", "marge_simpson.jpg", Faker::Simpsons]
]

users = []
chirps = []
user_setup.map do |u|
  users << obj = User.create(
    username: u[0],
    email: "#{u[0]}@linuxacademy.com",
    image_path: u[1],
    password: "abcd1234"
  )

  # Make Chirps
  15.times do
    method = obj.username == "chewie" ?  "wookie_sentence" : "quote"
    message = u[2].send(method)
    if message.length <= 141
      chirps << Chirp.new(
        message: message,
        user: obj,
        created_at: Date.today-rand(400)
      )
    end
    chirps.last.save!
  end
end

# Shuffle the chirps and make folks like them
chirps.shuffle!.each(&:save!)
chirps.each do |chirp|
  users.each do |user|
    # Don't like our own tweets
    next if chirp.user == user.id
    # Random like of a chirp per each user
    next if rand(0..1) == 0
    Like.create(chirp: chirp, user_id: user.id)
  end
end

users.each do |u|
  # Make Relationships
  users.each do |follow|
    # Don't follow self
    next if follow == u
    # Randomly decide if we should follow or not
    next if rand(0..1) == 0
    UserRelationship.create(user: u, followed_user: follow)
  end
end


