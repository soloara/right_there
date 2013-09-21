class PlacesPresenter
  
  def initialize data
    @data = data
  end
  
  def as_json options={}
    @data.map do |p|
      {
        id: p.uid.to_i,
        tickets_count: p.tickets_count,
        name: p.name,
        level: p.level,
        lat: p.lat,
        lng: p.lng
      }
    end.as_json
  end
  
end