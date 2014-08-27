require 'spec_helper'

describe SongRelation, :type => :model do
	
	context "equality" do
      let (:song) { Song.new(name: "Song1", artist: "Artist1") }
      let (:same_song) { Song.new(name: "Song1", artist: "Artist1") }
      let (:different_song) { Song.new(name: "Song2", artist: "Artist2") }

      let (:song_relation) { SongRelation.new }
      let (:same_relation) { SongRelation.new }
      let (:song_relation2) { SongRelation.new }

      before(:each) do
      	song_relation.songs << song
         song_relation.songs << different_song

         same_relation.songs << song.dup
         same_relation.songs << different_song.dup

         song_relation2.songs << different_song.dup
         song_relation2.songs << song.dup
      end

      subject { song_relation }
      it { should eq(same_relation) }
      it { should eq(song_relation2) }
	end

end