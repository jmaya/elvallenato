module ElVallenato
  
  class Search
    attr_reader :doc
    require 'open-uri'
    require 'CGI'
    
    def initialize(mode,query)
      @mode = mode
      @query = query
      url
    end

    def url
      return @url if !@url.nil?
      if @query.nil? or @query == ""
        @url = "http://www.elvallenato.com/letras/busqueda.php?x=&busca=#{@mode}&image.x=8&image.y=6"
      else
        @url = "http://www.elvallenato.com/letras/busqueda.php?x=#{CGI.escape(@query)}&busca=#{@mode}&image.x=12&image.y=11"
      end
    end

    def url=(url)
      @url = url
    end

    def next_url=(next_url)
      @next_url = next_url
    end

    def next_url
      partial_next = "http://www.elvallenato.com/letras/"
      @doc.search("a").each do |d|
        partial_next << d["href"] if d.inner_html == 'Siguiente >>'
      end
      @url = partial_next
      partial_next == "http://www.elvallenato.com/letras/" ? nil : partial_next
      #     @next_url
    end

    def load_content=(lc)
      @load_content = lc
      @doc = Hpricot(@load_content)
    end

    def fetch_content
      @load_content = open(@url).read
      @doc = Hpricot(@load_content)
    end
    
    def collect_links
      @doc.search(".class10").collect {|e| clean_url(e.at("a")["href"])}
    end

    def collect_lirics
      collect_links.collect {|l| Letra.new(open(clean_url(l)).read)}
    end

    def clean_url(url_in)
      first_part = url_in.gsub(/(\d+)\/.+$/,"\\1/")
      second_part = url_in.scan(/\d+\/(.+)$/)[0][0]
      #       url_in.gsub(/\s/, "+")
      first_part + CGI.escape(second_part)
    end

    def fetch
      load_content = open(clean_url(@url)).read
    end
  end
end
