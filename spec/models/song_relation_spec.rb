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
      	 p song
         song_relation.song1 = song
         song_relation.song2 = different_song

         same_relation.song1 = song
         same_relation.song2 = different_song

         song_relation2.song1 = different_song
         song_relation2.song2 = song
      end

      subject { song_relation }

      it { should eq same_relation }
      it { should eq song_relation2 }

	end

end