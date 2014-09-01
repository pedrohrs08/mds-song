module Relations
  class Song
    include Mongoid::Document

    field :name, type: String
    field :artist, type: String
    field :album, type: String 
     
    embedded_in :song_relation

    def ==(other_song)
      super(other_song) unless other_song.is_a?(Song)
      (name == other_song.name) && (artist == other_song.artist)
    end
  end
end