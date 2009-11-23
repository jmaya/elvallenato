module ElVallenato
  class Search
    require 'CGI'
    
    def initialize(mode,query)
      @mode = mode
      @query = query
    end

    def url
      if @query.nil? or @query == ""
        "http://www.elvallenato.com/letras/busqueda.php?x=&busca=#{@mode}&image.x=8&image.y=6"
      else
        "http://www.elvallenato.com/letras/busqueda.php?x=#{CGI.escape(@query)}&busca=#{@mode}&image.x=12&image.y=11"
      end
    end

    def next_url=(next_url)
      @next_url = next_url
    end

    def next_url
      partial_next = "http://www.elvallenato.com/letras/"
      @doc.search("a").each do |d|
        partial_next << d["href"] if d.inner_html == 'Siguiente >>'
      end
      partial_next == "http://www.elvallenato.com/letras/" ? '' : partial_next
      #     @next_url
    end

    def load_content=(load_content)
      @load_content = load_content
      @doc = Hpricot(@load_content)
    end

    def load_content
      @load_content
    end
    
    def collect_links
      @doc.search(".class10").collect {|e| e.at("a")["href"]}
    end

    def collect_lirics
      collect_links.collect {|l| Letra.new(l)}
    end
  end
end
