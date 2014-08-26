require 'spec_helper'

describe Song, :type => :model do
    
    context "class should have correct method " do
      subject { Song.new }
      
      it { should respond_to :name   }
      it { should respond_to :artist }
      it { should respond_to :album  }
      it { should respond_to :number_of_plays }
    end
    
    context "#number_of_plays" do
      before(:each) do
	    3.times { Song.create!(name: "Pop Song", artist: "Madonna") }
	  end

	  it "should return the number of occurrences in the db" do
         record = Song.new(name: "Pop Song", artist: "Madonna")
         expect(record.number_of_plays).to eq 3
	  end
    end

    context "equality" do
      let(:song) { Song.new(name: "Song1", artist: "Artist1") }
      let(:same_song) { Song.new(name: "Song1", artist: "Artist1")}
      let(:not_same_song) { Song.new(name: "Song2", artist: "Artist2")}

      subject { song }
      it { should eq same_song}
      it { should_not eq not_same_song}
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