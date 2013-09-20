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
      tickets: @data.tickets.map do |ticket|
        {
          email: ticket.email,
          place_id: ticket.place_id
        }
      end
    }
  end
  
end