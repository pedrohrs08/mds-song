class Song
  include Mongoid::Document

  field :name, type: String
  field :artist, type: String
  field :album, type: String
end