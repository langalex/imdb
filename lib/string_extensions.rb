require 'cgi'
require 'iconv'

module Imdb
  module StringExtensions
  
    def unescape_html
      Iconv.conv("UTF-8", 'ISO-8859-1', CGI::unescapeHTML(self))
    end
  
    def strip_tags
      gsub(/<\/?[^>]*>/, "")
    end
  end
end

String.send :include, Imdb::StringExtensions