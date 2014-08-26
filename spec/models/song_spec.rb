require 'spec_helper'

describe Song, :type => :model do
    
    context "class should have correct method " do
      subject { Song.new }
      
      it { should respond_to :name }
      it { should respond_to :artist }
      it { should respond_to :album }
    end
    
    context "communication with mongo db" do 
		before(:each) do
		   Song.create!(name: "Pop Song", artist: "Madonna")
		   Song.create!(name: "Folk Song", artist: "Folk Band")
		end

		it "should create a new song" do
		  first_song = Song.new(name: "Rock Song", artist: "Rolling Stones")
		  
		  expect{first_song.save}.to change{Song.count}.by 1
		end	

		it "should retrieve a song" do
	       first_song = Song.where(name: "Folk Song").first

	       expect(first_song.name).to eq "Folk Song"
		end
	end
end