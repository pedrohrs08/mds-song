module UsersHistory
	class UserHistory
		include Mongoid::Document
		field :username, type: String
		field :email, type: String

	end
end