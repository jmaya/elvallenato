require 'cgi'
require 'open-uri'
require 'URI'

module ElVallenato
  
  class Search
    attr_reader :mode,:term,:url

    def initialize(mode,term)
      @current_link = 0
      @mode = CGI.escape(mode)
      @term = CGI.escape(term)
      @url = "http://www.elvallenato.com/letras/busqueda.php?x=#{@term}&busca=#{@mode}&image.x=12&image.y=11" 
      @base = "http://" + URI.parse(@url).host
    end

    def content
      @content ||= OpenURI.open_uri(@url).read
    end

    def next_url
      return nil if @current_link == pages 
      if @current_link > 0
        link = @all_links[@current_link]["href"]
        @current_link += 1
        return [@base,link].join("/")
      else
        @all_links ||= Nokogiri::HTML.parse(content).css("span.class5 a")
        link = @all_links[0]["href"]
        @current_link += 1
        return [@base,link].join("/")
      end

    end
    def pages
        @pages ||= Nokogiri::HTML.parse(content).css("span.class5 a").count - 3
    end
  end
end
