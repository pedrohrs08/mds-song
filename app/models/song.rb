class Song
  include Mongoid::Document

  field :name, type: String
  field :artist, type: String
  field :album, type: String

  def number_of_plays
    Song.where(name: name, artist: artist, album: album).count
  end
end