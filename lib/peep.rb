class Peep

  include DataMapper::Resource
  
  property :id,     Serial 
  property :username,  String
  property :message, Text

  attr_reader :message

end