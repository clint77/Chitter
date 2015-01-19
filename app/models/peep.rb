class Peep

  include DataMapper::Resource

  property :id, Serial
  property :owner, String
  property :message, String
  has n, :tags, :through => Resource
end