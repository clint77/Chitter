class Peep

  include DataMapper::Resource

  property :id, Serial
  property :owner, String
  property :url, String
  property :message, String

end