require 'spec_helper'

describe SongRelation, :type => :model do
	context "available methods" do
       subject { SongRelation.new }
       it { should respond_to :songs }
       it { should respond_to :collaborative_factor }
   end
   
   context "available class methods" do
      subject { SongRelation }
      it { should respond_to :get_collaborative_factor }

      context "#get_collaborative_factor" do
         let (:song1) { Song.new(artist: "Artist1", name: "Song1") }
         let (:song2) { Song.new(artist: "Artist2", name: "Song2") }
         let (:song_relation){ SongRelation.new }

         before(:each) do
            song_relation.songs << song1
            song_relation.songs << song2
            song_relation.collaborative_factor = 3
            song_relation.save
         end

         it "should return the collaborative factor for two songs" do
            expect(SongRelation.get_collaborative_factor song1, song2).to eq 3
         end
      end
   end

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