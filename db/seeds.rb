# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
places = JSON.parse(File.open(Rails.root.join('config', 'areas.json')).read)

places['province'].each do |place|
  Place.create(name: place['text'], uid: place['id'], level: :province)
end

places['city'].each do |city|
  Place.create(name: city['text'], uid: city['id'], level: :city)
end

places['district'].each do |district|
  Place.create(name: district['text'], uid: district['id'], level: :district)
end
