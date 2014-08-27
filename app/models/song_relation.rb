class SongRelation
	include Mongoid::Document
     
    embeds_many :songs

    def ==(other_song_relation)
       songs.to_a == other_song_relation.songs.to_a  ||
       songs.to_a.reverse == other_song_relation.songs.to_a
    end

    validate :two_songs

    def two_songs
   	  errors.add(:songs, "The Relation must have two songs") if self.songs.count != 2
    end
end