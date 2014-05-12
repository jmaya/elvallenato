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
       links.size
    end

    def links 
      @page_links ||= Nokogiri::HTML.parse(content).css("span.class5 a").collect do |e|
        e["href"]  if e["href"] =~ /pg=\d+$/
      end.compact.sort.uniq
    end

    def liric_links
     @liric_links ||= Nokogiri::HTML.parse(content).css('.class10 a').collect do |e| 
       clean_url(e["href"])
     end.compact.sort.uniq
    end

    def clean_url(url)
      url =~ /letras\/letras\/(\d+)\/(.+?)$/
      id = $1
      song_name = CGI.escape($2)
      [@base,"letras","letras",id,song_name].join("/")
    end

    def letras 
      liric_links.collect do |link|
        Letra.new(OpenURI.open_uri(link).read)
      end
    end
  end
end
