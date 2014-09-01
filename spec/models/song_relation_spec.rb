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

      context "methods" do
         let (:song1) { Song.new(artist: "Artist1", name: "Song1") }
         let (:song2) { Song.new(artist: "Artist2", name: "Song2") }
         let (:song3) { Song.new(artist: "Artist3", name: "Song3") }
         let (:song_relation){ SongRelation.new }
         let (:song_relation2){ SongRelation.new }

         before(:each) do
             song_relation.songs << song1
             song_relation.songs << song2
             song_relation.collaborative_factor = 3
             song_relation.save

             song_relation2.songs << song1.dup
             song_relation2.songs << song3
             song_relation2.collaborative_factor = 7
             song_relation2.save
         end
         context "#get_collaborative_factor" do

            it "should return the collaborative factor for two songs" do
               expect(SongRelation.get_collaborative_factor song1, song2).to eq 3
            end

            it "should return collaborative_factor for two songs independent of the order" do
               expect(SongRelation.get_collaborative_factor song2, song1).to eq 3
            end

            it "should return collaborative_factor for the right pair" do
               expect(SongRelation.get_collaborative_factor song3, song1).to eq 7
            end
         end
         context "#save" do
           it "should edit an existing record instead of create a new one" do
               new_song_relation = SongRelation.new
               new_song_relation.songs << song2.dup
               new_song_relation.songs << song1.dup
               new_song_relation.collaborative_factor = 8
               expect { new_song_relation.save }.to raise_error { SongRelation.count }
               expect(SongRelation.get_collaborative_factor song2,song1).to eq 3
           end
         end

         context "#retrieve_object" do
           
            let(:song4) { Song.new(name: "Song4", artist: "Artist4") }
          
            it "should return a new record if it doesnt exist" do
               song_relation = SongRelation.retrieve_object(song1.dup,song4)
               expect(song_relation).to be_new_record
               expect(song_relation.songs).to include(song4)               
            end

            it "should return a record from the DB if it exists" do
               song_relation = SongRelation.retrieve_object(song1.dup,song2.dup)
               expect(song_relation).to_not be_new_record
               expect(song_relation.songs).to include(song1)  
            end
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