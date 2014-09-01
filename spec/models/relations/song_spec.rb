require 'spec_helper'

module Relations
describe Song, :type => :model do
    include Relations

    context "class should have correct method " do
      subject { Song.new }
      
      it { should respond_to :name   }
      it { should respond_to :artist }
      it { should respond_to :album  }
    end
    
 
    context "equality" do
      let(:song) { Song.new(name: "Song1", artist: "Artist1") }
      let(:same_song) { Song.new(name: "Song1", artist: "Artist1")}
      let(:not_same_song) { Song.new(name: "Song2", artist: "Artist2")}

      subject { song }
      it { should eq same_song}
      it { should_not eq not_same_song}
    end
end
end