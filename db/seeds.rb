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
