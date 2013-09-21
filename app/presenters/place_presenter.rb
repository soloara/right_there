class PlacePresenter
  
  def initialize data
    @data = data
  end
  
  def as_json options={}
    {
      id: @data.uid.to_i,
      tickets_count: @data.tickets_count,
      name: @data.name,
      level: @data.level,
      lat: @data.lat,
      lng: @data.lng
    }
  end
  
end