require File.dirname(__FILE__) + '/../lib/imdb'

samples_dir = File.dirname(__FILE__) + '/samples'

describe ImdbSearch do

  before(:each) do
    @imdb_search = ImdbSearch.new('Indiana Jones')
    @imdb_search.stub!(:open).and_return(open("#{samples_dir}/sample_search.html"))
  end
  
  it "should query IMDB url" do
    @imdb_search.should_receive(:open).with("http://www.imdb.com/find?s=all&q=Indiana+Jones").and_return(open("#{samples_dir}/sample_search.html"))
    @imdb_search.send(:document)
  end

  describe "movies" do

    it "should be a collection of ImdbMovie instances" do
      @imdb_search.movies.should have(59).imdb_movies
    end

    it "should include 'Indiana Jones and the Last Crusade'" do
      @imdb_search.movies.detect { |m| m.title == 'Indiana Jones and the Last Crusade' }.should_not be_nil
    end

    it "should have titles" do
      @imdb_search.movies.each do |movie|
        movie.title.should_not be_empty
      end
    end
    
    it "should not have titles with HTML tags" do
      @imdb_search.movies.each do |movie|
        movie.title.should_not match(/<.+>/)
      end
    end
    
  end

end

describe ImdbMovie do

  before(:each) do
    @imdb_movie = ImdbMovie.new('0097576', 'Indiana Jones and the Last Crusade')
    @imdb_movie.stub!(:open).and_return(open("#{samples_dir}/sample_movie.html"))
  end
  
  it "should query IMDB url" do
    @imdb_movie.should_receive(:open).with("http://www.imdb.com/title/tt0097576/").and_return(open("#{samples_dir}/sample_movie.html"))
    @imdb_movie.send(:document)
  end
  
  it "should get director" do
    @imdb_movie.director.should == 'Steven Spielberg'
  end
  
  it "should get the poster" do
    @imdb_movie.poster.should == 'http://ia.media-imdb.com/images/M/MV5BMTkzODA5ODYwOV5BMl5BanBnXkFtZTcwMjAyNDYyMQ@@._V1._SX95_SY140_.jpg'
  end
  
  it "should get the X first cast members"
  it "should get the writers"
  it "should get the release date"
  it "should get the genres"
  it "should get the plot"
  it "should get the length"
  it "should get the countries"
  it "should get the languages"
  it "should get the color"
  it "should get the company"
  it "should get the first X photos"

end