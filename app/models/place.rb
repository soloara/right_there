class Place < ActiveRecord::Base
  self.primary_key = :uid
  
  scope :province,  -> { where('uid like ?', '%0000') }
  
  LEVEL_REGEXPS = {
    province: /\d{4}$/,
    city:     /\d{2}$/,
    district: ''
  }
  
  def tickets
    pattern = self.uid.gsub LEVEL_REGEXPS[self.level.to_sym], '%'
    Ticket.where [ "place_id LIKE ?", pattern ]
  end
  
  def tickets_count
    self.tickets.count
  end
  
  def self.find(uid)
    find_by_uid uid.to_s
  end

end
