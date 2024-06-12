require 'open-uri'
require 'json'

# DECOMMENTER CE PASSAGE POUR SEED LES SILOS:
# puts "Destroying all Recycling spots"
# RecyclingSpot.destroy_all

# puts "Starting to seed the Recycling spots"
# url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.siloverre/all.json?maxfeatures=-1"
# glass_silo_serialized = URI.open(url).read
# glass_silo = JSON.parse(glass_silo_serialized)

# puts "(1/5) Creating glass silos..."

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

# puts "(2/5) Creating house waste silos..."
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

# puts "(3/5) Creating selective collection silos..."

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

# recycling_center_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gip_proprete.gipdecheterie_3_0_0/all.json?maxfeatures=-1&start=1"
# recycling_center_serialized = URI.open(recycling_center_url).read
# recycling_center = JSON.parse(recycling_center_serialized)

# puts "(4/5) Creating recycling centers..."
# # Check data paths!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# recycling_center["values"].each do |waste|
#   silo = RecyclingSpot.new(
#     address: waste["adresse"],
#     category: "recycling center",
#     latitude: waste["lat"],
#     longitude: waste["lon"],
#     telephone: waste["telephone"]
#   )
#   silo.tag_list.add("glass", "plastic", "paper", "aluminum", "house waste", "metal", "household applicances", "batteries")
#   silo.save!
# end

# composting_silo_url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.bornecompost/all.json?maxfeatures=-1&start=1"
# composting_silo_serialized = URI.open(composting_silo_url).read
# composting_silo = JSON.parse(composting_silo_serialized)

# puts "(5/5) Creating recycling center silos..."
# composting_silo["values"].each do |waste|
#   silo = RecyclingSpot.new(
#     address: waste["adresse"],
#     category: "composting silo",
#     latitude: waste["lat"],
#     longitude: waste["lon"]
#   )
#   silo.tag_list.add("compost")
#   silo.save!
# end


# puts "Recycling spots are all seeded"

puts "Destroying users"
User.destroy_all
puts "Destroying products"
Product.destroy_all

puts "Destroying informations"
RecyclingPointInfo.destroy_all

puts "Creating informations..."
RecyclingPointInfo.create!(
  title: "Bac à couvercle jaune",
  subheading: "Tous les emballages et papiers",
  illustration: "trash_bins/yellow_bin_final.png",
  packaging: ["Emballages en plastique: bouteilles, pots de yaourt, sachets de surgelés...",
              "Emballages en métal: canettes, capsules de café, conserves...",
            "Papiers et emballages en carton: cartons à pizza, enveloppes..."],
  description_title: "Pour éviter les emballages et papiers durant mes courses:",
  descriptions: ["Je présente mes propres contenants réutilisables (boîtes, sachets) aux commerçants, ces derniers ne pouvant pas les refuser",
                "Je privilégie les produits en vrac et les grands formats"],
  we_win: "En buvant l'eau du robinet du Grand Lyon, une famille de 4 personnes économise environ 200 euros en moyenne chaque année!",
  helper: "Vidés, non lavés, non imbriqués et en vrac. Cartons à plat",
  no_no: ["Sacs d'ordures ménagères", "Couches", "Piles et batteries", "Objets plastiques"],
  search_terms_hidden: ["Briques alimentaire", "Emballages en carton", "Emballages",
                      "Emballages en plastique", "Bouteilles et flacons en plastique", "Bouteilles en plastique",
                      "Pots de yaourt", "Sachets de surgelés", "Canettes", "Capsules de café", "Conserves",
                      "Cartons à pizza", "Enveloppes", "Boîtes", "Sachets", "Produits en vrac", "Grands formats", "Papiers",
                    "journal", "journaux", "aluminium"]
)

RecyclingPointInfo.create!(
  title: "Poubelle à verre",
  subheading: "Recyclage",
  illustration: "trash_bins/green_trash_final.png",
  packaging: ["Bouteilles", "Bocaux", "Flacons"],
  description_title: "Pour limiter mes déchets:",
  descriptions: ["J'achète des bouteilles et bocaux consignés. Une fois rapportés en magasin, les contenants sont réutilisés"],
  we_win: "Chaque tonne consignée ou triée se transforme en un don pour la recherche contre le cancer",
  helper: "Vidés, sans couvercle et en vrac",
  no_no: ["Vaisselle cassée", "Miroirs cassés"],
  search_terms_hidden: ["Pots et bocaux en verre", "Bouteilles en verre", "bocal", "flacon", "bouteille", "verre",
                        "pot en verre"]
)

RecyclingPointInfo.create!(
  title: "Bac à couvercle bleu",
  subheading: "Papiers, journaux, prospectus...",
  illustration: "trash_bins/blue_trash_final.png",
  packaging: ["Cahiers, bloc-notes, impressions","Journaux, catalogues et prospectus",
              "Courriers, enveloppes et livres"],
  description_title: "",
  descriptions: [""],
  we_win: "",
  helper: "",
  no_no: [],
  search_terms_hidden: ["Cahiers, bloc-notes, impressions","Journaux, catalogues et prospectus",
              "Courriers, enveloppes et livres", "Papiers", "journal"]
)

# Bac a compostage
RecyclingPointInfo.create!(
  title: "Bac à compostage",
  subheading: "Déchets alimentaires",
  illustration: "trash_bins/composte_final.png",
  packaging: ["Préparations de repas et restes", "Marc de café et thé",
            "Aliments périmés sans emballage"],
  description_title: "Pour éviter le gaspillage alimentaire au quotidien:",
  descriptions: ["Je fais mes courses selon mon menu de la semaine.",
                "S'il y a des restes, je congèle"],
  we_win: "Le compost naturel obtenu permet d'enrichir les sols",
  helper: "En vrac ou dans un sac en papier",
  no_no: ["Sacs plastiques même compostables"],
  search_terms_hidden: ["compost", "compostage", "composter", "composteur",
                        "déchets alimentaires", "déchets organiques", "déchets verts",
                      "Matières brunes", "Matières vertes", "déchets de cuisine","banane",
                    "fruits", "légumes", "épluchures", "restes de repas", "pain", "pâtes",
                  "riz", "pâtes", "pommes de terre", "coquilles d'oeufs", "marc de café",
                "thé", "filtre à café", "sachet de thé", "sachet de café", "sachet de thé"]
)

RecyclingPointInfo.create!(
  title: "Bac à couvercle gris",
  subheading: "Ordures ménagères, incinération",
  illustration: "trash_bins/black_trash_final.png",
  packaging: ["Couches", "Objets plastiques", "Vaisselle cassée en verre ou en porcelaine", "Essuie-tout, mouchoirs et lingettes"],
  description_title: "Pour ce qui n'a pu être trié:",
  descriptions: ["Je jette les déchets qui n'ont pu être évités et qui ne peuvent être ni recyclés ni compostés"],
  we_win: "",
  helper: "Dans un sac fermé",
  no_no: ["Piles et batteries", "Ampoules"],
  search_terms_hidden: ["Ce qu'il reste après le tri", "impossible",
"couches", "vaisselle cassée", "porcelaine", "essuie-tout",
"mouchoirs", "lingettes"]
)

RecyclingPointInfo.create!(
  title: "En déchèterie",
  subheading: "Déchets occasionnels, réemploi et recyclage",
  illustration: "trash_bins/decheterie_final.png",
  packaging: ["Déchets verts", "Electroménager, appareils électriques et électroniques",
              "Bois", "Déchets dangereux", "Meubles abîmés, encombrants", "Métal",
              "Gravats et plâtre", "Cartons"],
  description_title: "Pour éviter de jeter un objet:",
  descriptions: ["J'essaie de le réparer", "Je le réemploie autrement",
    "Je le donne"],
    we_win: "Les donneries installées dans les déchèteries sont des espaces de dons d'objets encore en bon état. Ces derniers sont remis à des associations partenaires qui les redistribuent",
    helper: "Je rapporte en magasin: piles, ampoules, petits appareils électriques, jouets, articles de sport, articles de bricolage",
    no_no: [],
    search_terms_hidden: ["Déchets verts", "Electroménager, appareils électriques et électroniques",
      "Bois", "Déchets dangereux", "Meubles abîmés, encombrants", "Métal",
      "Gravats et plâtre", "Cartons", "Déchèterie", "déchetterie", "déchetteries",
      "déchèteries", "déchets occasionnels", "réemploi", "recyclage", "réparer"]
  )

# Seeds user test
user_test = User.create!(
  username: '@TimTeam',
  emission: '60',
  email: 'lewagon@lewagon.com',
  password: '123456',
  avatar: 'userpictures/photo Tim.jpg'
)

# Seeds products
puts "Seeding products"

product = Product.new(
  user: user_test,
  name: 'Porc à la Dijonnaise et ses pommes de terre',
  material: 'cardboard',
  score: '92',
  image_url: 'products/Porcdijonnaise.jpg',
  description: '1 étui en carton à recycler, 1 barquette en plastique à trier, 1 opercule en plastique à trier',
  barcode: '3245414146068',
  carbon: '555'
)
product.tag_list.add("paper")
product.save!

product = Product.new(
  user: user_test,
  name: 'Haribo Croco',
  material: 'plastic',
  score: '74',
  image_url: 'products/Haribocroco.jpg',
  description: '1 emballage plastique à trier',
  barcode: '3103220035214',
  carbon: '436'
)
product.tag_list.add("plastic")
product.save!

product = Product.new(
  user: user_test,
  name: 'Bière 1664 25cl',
  material: 'glass',
  score: '81',
  image_url: 'products/Biere1664.png',
  description: '1 bouteille en verre à recycler, 1 capsule en métal à recycler',
  barcode: '3080216052885',
  carbon: '280'
)
product.tag_list.add("glass")
product.save!

product = Product.new(
  user: user_test,
  name: "Sardines de Bretagne préparées à l'ancienne à l'huilde d'olive",
  material: 'aluminum',
  score: '64',
  image_url: 'products/SardinesBretagne.png',
  description: '1 conserve en almunium à recycler, 1 emballage carton à recycler',
  barcode: '3560070894772',
  carbon: '487'
)
product.tag_list.add("aluminum")
product.save!

product = Product.new(
  user: user_test,
  name: 'Ananas en morceaux',
  material: 'metal',
  score: '76',
  image_url: 'products/Ananas.jpg',
  description: '1 boîte de conserve à recycler',
  barcode: '3560070347308',
  carbon: '442'
)
product.tag_list.add("metal")
product.save!

product = Product.new(
  user: user_test,
  name: 'Nutella',
  material: 'glass',
  score: '22',
  image_url: 'products/Nutella.jpg',
  description: '1 pot en verre à recycler, 1 bouchon en plastique à trier',
  barcode: '3017620422003',
  carbon: '3024'
)
product.tag_list.add("glass")
product.save!

product = Product.new(
  user: user_test,
  name: "Huilde d'olive vierge extra 50cl",
  material: 'glass',
  score: '81',
  image_url: 'products/huileolive.webp',
  description: '1 bouteille en verre à recycler, 1 bouchon en métal à recycler',
  barcode: '3270190008279',
  carbon: '49'
)
product.tag_list.add("glass")
product.save!

product = Product.new(
  user: user_test,
  name: 'President Camembert',
  material: 'paper',
  score: '92',
  image_url: 'products/camembert.jpg',
  description: '1 emballage carton à recycler',
  barcode: '3228021170039',
  carbon: '1310'
)
product.tag_list.add("paper")
product.save!

product = Product.new(
  user: user_test,
  name: 'Madeleines Moelleuses',
  material: 'plastic',
  score: '54',
  image_url: 'products/madeleines.jpg',
  description: '1 emballage plastique à trier',
  barcode: '3270190207887',
  carbon: '457'
)
product.tag_list.add("plastic")
product.save!

product = Product.new(
  user: user_test,
  name: 'Sauce soja salée Suzy Wan 143ml',
  material: 'glass',
  score: '71',
  image_url: 'products/soja.webp',
  description: '1 boouteille en verre à recycler, 1 bouchon en plastique à trier',
  barcode: '4002359018268',
  carbon: '106'
)
product.tag_list.add("glass")
product.save!

# Seeds users for ranking
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

puts "Seeding users done"

puts "Seeds are all done"
puts "Now get back to work or I'll fire you"
puts "WTF WHO TOUCHED MY SEEDS MESSAGES?!"
