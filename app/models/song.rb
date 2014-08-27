class Song
  include Mongoid::Document

  field :name, type: String
  field :artist, type: String
  field :album, type: String 

  belongs_to :second_position_relation, class_name: "SongRelation", inverse_of: :song2
  belongs_to :first_position_relation, class_name: "SongRelation", inverse_of: :song1

  def number_of_plays
    Song.where(name: name, artist: artist, album: album).count
  end

  def ==(other_song)
    (name == other_song.name) && (artist == other_song.artist)
  end
end