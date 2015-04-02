# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?

    users = []
    movies = []
    reviews = []
        
    users << User.create(email: 'andsbf@gmail.com', password: '123456', password_confirmation: '123456', firstname: 'Anderson', lastname: 'Saunders', admin: true)

    20.times do |i|
        users << User.create(
            firstname: Faker::Name.first_name,
            lastname: Faker::Name.last_name,
            email: Faker::Internet.email,
            password: "123456",
            password_confirmation: "123456"
        )
    end


    50.times do |i|
        movies << Movie.create(
          title: Faker::App.name,
          director: Faker::Name.name,
          runtime_in_minutes: rand(150),
          description: Faker::Lorem.paragraph,
          release_date: Faker::Time.forward(365),
          remote_image_url: Faker::Avatar.image 
        )
    end


    100.times do |i|
        reviews << Review.create(
          text: Faker::Lorem.paragraph,
          rating_out_of_ten: rand(1..10),
          user: users.sample,
          movie: movies.sample
        )
    end
end
