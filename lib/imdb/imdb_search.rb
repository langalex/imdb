module Imdb
  class Search

    def initialize(query)
      @query = query
    end

    def movies
      @movies ||= (exact_match? ? parse_movie : parse_movies)
    end

    private
  
    def document
      @document ||= Hpricot(open("http://www.imdb.com/find?q=#{CGI::escape(@query)};s=tt").read)
    end
  
    def parse_movies
      document.search('a[@href^="/title/tt"]').reject do |element|
        element.innerHTML.strip_tags.empty?
      end.map do |element|
        [element['href'][/\d+/], element.innerHTML.strip_tags.unescape_html]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end
  
    def parse_movie
      id = document.at("a[@name='poster']")['href'][/\d+$/]
      title = document.at("h1").innerHTML.split('<span').first.strip.unescape_html
      [Imdb::Movie.new(id, title)]
    end
  
    def exact_match?
      document.at("title[text()='IMDb Search']").nil?
    end

  end
end