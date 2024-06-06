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

RecyclingSpot.destroy_all

url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.siloverre/all.json?maxfeatures=-1"
glass_silo_serialized = URI.open(url).read
glass_silo = JSON.parse(glass_silo_serialized)

glass_silo["values"].each do |glass|
  silo = RecyclingSpot.new(
    address: glass["adresse"],
    category: "glass",
    latitude: glass["lat"],
    longitude: glass["lon"]
  )
  silo.tag_list.add("glass")
  silo.save!
end

house_waste_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.orduresmenageres/all.json?maxfeatures=-1&start=1"
house_waste_silo_serialized = URI.open(house_waste_url).read
house_waste_silo = JSON.parse(house_waste_silo_serialized)

house_waste_silo["values"].each do |waste|
  silo = RecyclingSpot.new(
    address: waste["adresse"],
    category: "house waste",
    latitude: waste["lat"],
    longitude: waste["lon"]
  )
  silo.tag_list.add("house waste")
  silo.save!
end

selective_collection_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.collecteselective/all.json?maxfeatures=-1&start=1"
selective_collection_serialized = URI.open(selective_collection_url).read
selective_collection = JSON.parse(selective_collection_serialized)

selective_collection["values"].each do |waste|
  silo = RecyclingSpot.new(
    address: waste["adresse"],
    category: "selective collection",
    latitude: waste["lat"],
    longitude: waste["lon"]
  )
  silo.tag_list.add("glass", "plastic", "paper", "aluminum", "house waste", "metal")
  silo.save!
end

# Robin seed perso because no camera
# Create a user
user_test = User.create!(email: 'test@example.com',
  password: '123456',
  password_confirmation: '123456')

Product.create!(
  name: 'Bol de grosses glaires', # Replace with your actual product name
  material: 'en:plastic', # Replace with your actual product material
  image_url: 'data:image/jpeg;base64,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', # Replace with your actual image URL
  user: user_test
)

Product.create!(
  name: 'Bouteille de prout enfermé', # Replace with your actual product name
  material: 'en:metal', # Replace with your actual product material
  image_url: 'data:image/jpeg;base64,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', # Replace with your actual image URL
  user: user_test
)

Product.create!(
  name: 'Récipient de vomi scellé', # Replace with your actual product name
  material: 'en:paper', # Replace with your actual product material
  image_url: 'data:image/jpeg;base64,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', # Replace with your actual image URL
  user: user_test
)

Product.create!(
  name: 'Boule à neige de caca', # Replace with your actual product name
  material: 'en:aluminum', # Replace with your actual product material
  image_url: 'data:image/jpeg;base64,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', # Replace with your actual image URL
  user: user_test
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
