# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_setup = [
  ["lskywalker", "luke_skywalker.jpg"],
  ["hsolo", "han_solo.jpg"],
  ["lorgana", "leia_organa.jpg"],
  ["chewie", "chewie.jpg"],
  ["baddad", "darth_vader.jpg"],
  ["bfett", "boba_fett.jpg"]
]

users = user_setup.map do |u|
  User.create(
    username: u.first,
    email: "#{u.first}@linuxacademy.com",
    image_path: u.last,
    password: "abcd1234"
  )
end

chirps = []
users.each do |u|
  # Make Relationships
  users.each do |follow|
    # Don't follow self
    next if follow == u
    # Randomly decide if we should follow or not
    next if rand(0..1) == 0
    UserRelationship.create(user: u, followed_user: follow)
  end

  # Make Chirps
  15.times do
    message = Faker::StarWars.quote
    chirps << Chirp.new(message: message, user: u) if message.length <= 141
    chirps.last.created_at = Date.today-rand(400)
    chirps.last.save!
  end
end

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
