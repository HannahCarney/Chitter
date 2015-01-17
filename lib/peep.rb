class Peep

  include DataMapper::Resource
  
  property :id,     Serial 
  property :message, Text
  property :peep_timestamp, Time
  property :username, String
 

end
