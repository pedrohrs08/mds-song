class SongRelation
	include Mongoid::Document
    before_save :prevent_saving_if_record_exists

    embeds_many :songs
    field :collaborative_factor, type: Integer 

    def self.retrieve_object(song1,song2)
       relations = SongRelation.relation_by_songs(song1,song2) 
       return relations.first if relations.count > 0 
       song_relation = SongRelation.new
       song_relation.songs << song1
       song_relation.songs << song2
       song_relation
    end
    
    def ==(other_song_relation)
       songs.to_a == other_song_relation.songs.to_a  ||
       songs.to_a.reverse == other_song_relation.songs.to_a
    end

    validate :two_songs

    def two_songs
   	  errors.add(:songs, "The Relation must have two songs") if self.songs.to_a.count != 2
    end

    def self.get_collaborative_factor(song1, song2)
      relations = SongRelation.relation_by_songs(song1,song2)
      relations.size == 0 ? 0 : relations.first.collaborative_factor
    end

    scope :relation_by_songs, ->(song1, song2) do 
      first_song = { "name" => song1.name, "artist" => song1.artist }
      second_song = {"name" => song2.name, "artist" => song2.artist }      
      SongRelation.and({ :songs.elem_match => first_song },{ :songs.elem_match => second_song })
    end

    private
    def prevent_saving_if_record_exists
      return false if self.songs.to_a.count != 2
      relations = SongRelation.relation_by_songs(self.songs[0],self.songs[1])
      return true if relations.count == 0      
      raise "Relation is already in the DB, please retrieve it before saving it"
    end
end