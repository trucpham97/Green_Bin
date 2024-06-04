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
  RecyclingSpot.create!(
    address: glass["adresse"],
    category: "glass",
    latitude: glass["lat"],
    longitude: glass["lon"]
  )
end
