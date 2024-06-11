require 'open-uri'
require 'json'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# DECOMMENTER CE PASSAGE POUR SEED LES SILOS:
# puts "Destroying all Recycling spots"
# RecyclingSpot.destroy_all

# puts "Starting to seed the Recycling spots"
# url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.siloverre/all.json?maxfeatures=-1"
# glass_silo_serialized = URI.open(url).read
# glass_silo = JSON.parse(glass_silo_serialized)

# puts "(1/3) Creating glass silos..."

# glass_silo["values"].each do |glass|
#   silo = RecyclingSpot.new(
#     address: glass["adresse"],
#     category: "glass",
#     latitude: glass["lat"],
#     longitude: glass["lon"]
#   )
#   silo.tag_list.add("glass")
#   silo.save!
# end

# house_waste_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.orduresmenageres/all.json?maxfeatures=-1&start=1"
# house_waste_silo_serialized = URI.open(house_waste_url).read
# house_waste_silo = JSON.parse(house_waste_silo_serialized)

# puts "(2/3) Creating house waste silos..."
# house_waste_silo["values"].each do |waste|
#   silo = RecyclingSpot.new(
#     address: waste["adresse"],
#     category: "house waste",
#     latitude: waste["lat"],
#     longitude: waste["lon"]
#   )
#   silo.tag_list.add("house waste")
#   silo.save!
# end

# selective_collection_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.collecteselective/all.json?maxfeatures=-1&start=1"
# selective_collection_serialized = URI.open(selective_collection_url).read
# selective_collection = JSON.parse(selective_collection_serialized)

# puts "(3/3) Creating selective collection silos..."

# selective_collection["values"].each do |waste|
#   silo = RecyclingSpot.new(
#     address: waste["adresse"],
#     category: "selective collection",
#     latitude: waste["lat"],
#     longitude: waste["lon"]
#   )
#   silo.tag_list.add("glass", "plastic", "paper", "aluminum", "house waste", "metal")
#   silo.save!
# end

# Robin seed perso because no camera
# Create a user
puts "Destroying users"
User.destroy_all
puts "Destroying products"
Product.destroy_all

user_test = User.create!(
  username: '@TimTeam',
  emission: '60',
  email: 'lewagon@lewagon.com',
  password: '123456',
  avatar: 'userpictures/photo Tim.jpg'
)

# Seeds de produits
puts "Seeding products"

Product.create!(
  user: user_test,
  name: 'Porc à la Dijonnaise et ses pommees de terre',
  material: 'en:cardboard',
  score: '92',
  image_url: 'products/Porcdijonnaise.jpg',
  description: '1 étui en carton à recycler, 1 barquette en plastique à trier, 1 opercule en plastique à trier',
  barcode: '3245414146068'
)

Product.create!(
  user: user_test,
  name: 'Haribo Croco',
  material: 'en:plastic',
  score: '74',
  image_url: 'products/Haribocroco.jpg',
  description: '1 emballage plastique à trier',
  barcode: '3103220035214'
)

Product.create!(
  user: user_test,
  name: 'Bière 1664 25cl',
  material: 'en:green-glass',
  score: '81',
  image_url: 'products/Biere1664.png',
  description: '1 bouteille en verre à recycler, 1 capsule en métal à recycler',
  barcode: '3080216052885'
)

Product.create!(
  user: user_test,
  name: "Sardines de Bretagne préparées à l'ancienne à l'huilde d'olive",
  material: 'en:aluminium',
  score: '64',
  image_url: 'products/SardinesBretagne.png',
  description: '1 conserve en almunium à recycler, 1 emballage carton à recycler',
  barcode: '3560070894772'
)

Product.create!(
  user: user_test,
  name: 'Ananas en morceaux',
  material: 'en:metal',
  score: '76',
  image_url: 'products/Ananas.jpg',
  description: '1 boîte de conserve à recycler',
  barcode: '3560070347308'
)

Product.create!(
  user: user_test,
  name: 'Nutella',
  material: 'en:clear-glass',
  score: '22',
  image_url: 'products/Nutella.jpg',
  description: '1 pot en verre à recycler, 1 bouchon en plastique à trier',
  barcode: '3017620422003'
)

# Product.create!(
#   user: user_test,
#   name: '',
#   material: '',
#   score: '',
#   image_url: '',
#   description: '',
#   barcode: '8711000522967'
# )

# Product.create!(
#   user: user_test,
#   name: '',
#   material: '',
#   score: '',
#   image_url: '',
#   description: '',
#   barcode: ''
# )

# Product.create!(
#   user: user_test,
#   name: ,
#   material: ,
#   score: ,
#   image_url: ,
#   description: ,
#   barcode:
# )

# Product.create!(
#   user: user_test,
#   name: ,
#   material: ,
#   score: ,
#   image_url: ,
#   description: ,
#   barcode:
# )



# Seeds d'utilisateurs pour le classement
puts "Seeding users"
User.create!(
  username: '@DenverLeDernierDino',
  emission: '0',
  email: 'test1@gmail.com',
  password: '123456',
  avatar: 'userpictures/Denverthelastdino.jpg'
)

User.create!(
  username: '@AlexMieral',
  emission: '8',
  email: 'test2@gmail.com',
  password: '123456',
  avatar: 'userpictures/Alex.jpg'
)

User.create!(
  username: '@Mercuriot',
  emission: '79',
  email: 'test3@gmail.com',
  password: '123456',
  avatar: 'userpictures/ThoMercuriot.jpg'
)

User.create!(
  username: '@TrucPham',
  emission: '41',
  email: 'test4@gmail.com',
  password: '123456',
  avatar: 'userpictures/TrucBTSLover.png'
)

User.create!(
  username: '@Messycodegames',
  emission: '42',
  email: 'test5@gmail.com',
  password: '123456',
  avatar: 'userpictures/Rob1.jpg'
)

User.create!(
  username: '@Choucrouteland',
  emission: '13',
  email: 'test6@gmail.com',
  password: '123456',
  avatar: 'userpictures/Ptitien.jpg'
)

User.create!(
  username: '@TheG',
  emission: '61',
  email: 'test7@gmail.com',
  password: '123456',
  avatar: 'userpictures/GGraldine.jpg'
)

User.create!(
  username: '@Anatole',
  emission: '51',
  email: 'test8@gmail.com',
  password: '123456',
  avatar: 'userpictures/Joaquin.jpg'
)

User.create!(
  username: '@xX_T-O_Xx',
  emission: '38',
  email: 'test9@gmail.com',
  password: '123456',
  avatar: 'userpictures/Theo.jpg'
)

User.create!(
  username: '@Egovox',
  emission: '44',
  email: 'test10@gmail.com',
  password: '123456',
  avatar: 'userpictures/Steph.jpg'
)

User.create!(
  username: '@EtLesHautNords',
  emission: '33',
  email: 'test11@gmail.com',
  password: '123456',
  avatar: 'userpictures/Eleonore.jpg'
)

User.create!(
  username: '@LadyCapulet',
  emission: '29',
  email: 'test12@gmail.com',
  password: '123456',
  avatar: 'userpictures/Jess.jpg'
)

User.create!(
  username: '@BCBen',
  emission: '22',
  email: 'test13@gmail.com',
  password: '123456',
  avatar: 'userpictures/Ben.png'
)

User.create!(
  username: '@Yanis51commelepastis',
  emission: '7',
  email: 'test14@gmail.com',
  password: '123456',
  avatar: 'userpictures/YanisPastis.png'
)

User.create!(
  username: '@NicoGone69',
  emission: '38',
  email: 'test15@gmail.com',
  password: '123456',
  avatar: 'userpictures/Nico.jpg'
)

User.create!(
  username: '@LeWagon',
  emission: '73',
  email: 'test16@gmail.com',
  password: '123456',
  avatar: 'userpictures/Lewagon.jpg'
)
# recycling_center_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gip_proprete.gipdecheterie_3_0_0/all.json?maxfeatures=-1&start=1"
# recycling_center_serialized = URI.open(recycling_center_url).read
# recycling_center = JSON.parse(recycling_center_serialized)

# Check data paths!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# recycling_center["values"].each do |waste|
#   RecyclingSpot.create!(
#     address: waste["adresse"],
#     category: "recycling center",
#     latitude: waste["lat"],
#     longitude: waste["lon"]
#   )
# end

puts "Seeds are all done"
puts "Now get back to work or I'll fire you"
