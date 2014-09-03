module UsersHistory
	class ListenedSongs
 		include Mongoid::Document

 		field :name, type: String
 		field :artist, type: String
 		field :album, type: String
 		field :times_played, type: Integer
 		field :location, type: Array, default: []

 		embedded_in :user
	end
end