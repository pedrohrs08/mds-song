class Song
  include Mongoid::Document

  field :name, type: String
  field :artist, type: String
  field :album, type: String 
   
  embedded_in :song_relation

  def number_of_plays
    Song.where(name: name, artist: artist, album: album).count
  end

  def ==(other_song)
    super(other_song) unless other_song.is_a?(Song)
    (name == other_song.name) && (artist == other_song.artist)
  end
end