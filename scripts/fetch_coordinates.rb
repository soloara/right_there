require 'json'
require 'open-uri'
require 'yaml'

places = JSON.parse(File.open('areas.json').read)
provinces = places['province']
cities = places['city']
districts = places['district']

provinces.each do |p|
  uri = URI.parse 'http://api.map.baidu.com/geocoder/v2/'
  params = { :address => p['text'], :ak => '256E60A3a4b1d6a221b69c367e04ffe7', output: :json }
  uri.query = URI.encode_www_form( params )
  result = JSON.parse uri.open.read
  puts result
  if (geo = result['result']) && result['status'] == 0
    p['lat'] = geo['location']['lat']
    p['lng'] = geo['location']['lng']
    p['precise'] = geo['precise']
    p['confidence'] = geo['confidence']
  end
  puts 'lat: ' + p['lat'].to_s
  puts 'lng: ' + p['lng'].to_s
end

cities.each do |p|
  begin
    uri = URI.parse 'http://api.map.baidu.com/geocoder/v2/'
  
    province_id = p['id'].gsub(/\d{4}$/, '0000')
    province = (provinces.select { |v| v['id'] == province_id })[0]
  
    params = { :address => "#{province['text']} #{p['text']}", :ak => '256E60A3a4b1d6a221b69c367e04ffe7', output: :json }
    uri.query = URI.encode_www_form( params )
    result = JSON.parse uri.open.read
    if (geo = result['result']) && result['status'] == 0
      p['lat'] = geo['location']['lat']
      p['lng'] = geo['location']['lng']
      p['precise'] = geo['precise']
      p['confidence'] = geo['confidence']
    end
    puts "#{province['text']} #{p['text']}"
    puts 'lat: ' + p['lat'].to_s
    puts 'lng: ' + p['lng'].to_s
  rescue => e
    puts p
  end
end

districts.each do |p|
  begin
    uri = URI.parse 'http://api.map.baidu.com/geocoder/v2/'
  
    province_id = p['id'].gsub(/\d{4}$/, '0000')
    province = (provinces.select { |v| v['id'] == province_id })[0]
    
    city_id = p['id'].gsub(/\d{2}$/, '00')
    city = (cities.select { |v| v['id'] == city_id })[0]
  
    params = { :address => "#{province['text']} #{city['text']} #{p['text']}", :ak => '256E60A3a4b1d6a221b69c367e04ffe7', output: :json }
    uri.query = URI.encode_www_form( params )
    result = JSON.parse uri.open.read
    if (geo = result['result']) && result['status'] == 0
      p['lat'] = geo['location']['lat']
      p['lng'] = geo['location']['lng']
      p['precise'] = geo['precise']
      p['confidence'] = geo['confidence']
    end
    puts "#{province['text']} #{city['text']} #{p['text']}"
    puts 'lat: ' + p['lat'].to_s
    puts 'lng: ' + p['lng'].to_s
  rescue => e
    puts e.message
    puts e.backtrace.join("\n")
    puts p
  end
end

File.open('area_with_coordinates.yml', 'w+') do |file|
  places = {
    province: provinces,
    city: cities,
    district: districts
  }
  file.write places.to_yaml
end