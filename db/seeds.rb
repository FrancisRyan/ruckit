# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create dummy catetories
10.times do
    Category.create(
         name: Faker::Team.name 
     )
 end
 
Faker::Team.name 
# Create dummy users
 5.times do
         user = User.create(
         full_name: Faker::Name.name,
         email: Faker::Internet.free_email,
         about: Faker::Quote.matz,
         password: '123456',
         from: Faker::Address.city,
         team: Faker::Sports::Football.team,
         created_at: Date.today
    )
Faker::Sports::Football.team #=> "Manchester United"
   user.avatar.attach(                
        io: image = open("https://i.pravatar.cc/300"),
        filename: "avatar#{user.id}.jpg", 
        content_type: 'image/jpg'
    )
 end

# Create dummy Requests

# 10.times do
#     random_user = User.all.sample(1)[0]
#     category = Category.all.sample(1)[0]
#     request = Request.create(
#         title: Faker::Job.title,
#         description: Faker::Quote.matz,
#         category_id: category.id
#         location: Faker::Address.city,
#         age: Faker::Number.between(1, 10),
#        
#     )
# end

#10.times do
#    random_user = User.all.sample(1)[0]
#    category = Category.all.sample(1)[0]
#   fixture = Fixture.create(
#        title: Faker::Job.unique.title,
#        description: Faker::Quote.matz,
#        active: Faker::Boolean.boolean,
#        user_id: random_user.id,
#        category_id: category.id
#    )
#    number = Faker::Number.between(1, 3)
#    fixture.photos.attach(
#        io: File.open("app/assets/images/fixture_cover_#{number}.jpg"),
#        filename: "category_#{number}.jpeg"
#    )    
#    fixture.details.create(
#        pricing_type: 0,
#        title: Faker::Job.title,
#        description: Faker::Quote.matz,
#        age: Faker::Number.between(1, 9),
#        match_time: Faker::Number.between(20, 30),
#        location: Faker::Address.city,
#    )
#    fixture.details..create(
#        pricing_type: 1,
#        title: Faker::Job.title,
#        description: Faker::Quote.matz,
#        age: Faker::Number.between(10, 19),
#        match_time: Faker::Number.between(10, 19),
#        location: Faker::Address.city,
#    )
#    fixture.details..create(
#        pricing_type: 2,
#        title: Faker::Job.title,
#        description: Faker::Quote.matz,
#        age: Faker::Number.between(20, 35),
#        match_time: Faker::Number.between(1, 10),
#        location: Faker::Address.city,
#    )
#end
