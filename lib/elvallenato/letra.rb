module ElVallenato
  class Letra
    
    attr_reader :content
    
    def initialize(content)
      
      @content = content
      @doc = Hpricot(@content)
    end

    def title
      @doc.at(".text_title").inner_html
    end

    def body
      @doc.search("td .text_std")[6].inner_html.gsub(/<br \/>/, "\n")
    end

    def composer
      @doc.search("td .text_std")[9].inner_html
    end

    def artist
      @doc.search("td .text_std")[8].inner_html
    end
    
  end
end
