class SongRelation
	include Mongoid::Document
     
    embeds_many :songs
    field :collaborative_factor, type: Integer 

    def ==(other_song_relation)
       songs.to_a == other_song_relation.songs.to_a  ||
       songs.to_a.reverse == other_song_relation.songs.to_a
    end

    validate :two_songs

    def two_songs
   	  errors.add(:songs, "The Relation must have two songs") if self.songs.to_a.count != 2
    end

    def self.get_collaborative_factor(song1, song2)
      SongRelation.where(songs: { [song1,song2] } ).count
    end
end