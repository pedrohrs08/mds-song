class SongRelation
	include Mongoid::Document
     
    has_one :song1, class_name: "Song", inverse_of: :first_position_relation
    has_one :song2, class_name: "Song", inverse_of: :second_position_relation
    field :collaborative_factor, type: Integer

    def ==(other_song_relation)
       (((song1 == other_song_relation.song1) && (song2 == other_song_relation.song2)) ||
       ((song2 == other_song_relation.song1) && (song1 == other_song_relation.song2)))
    end

end