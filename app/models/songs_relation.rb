class SongsRelation
  embeds_one :song, as: :song1
  embeds_one :song, as: :song2
  field :factor, type: Integer
end