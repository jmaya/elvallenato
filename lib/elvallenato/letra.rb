# -*- coding: utf-8 -*-

module ElVallenato
  class Letra
    
    attr_reader :content
    
    def initialize(content)
      @content = content
      @doc = Nokogiri::HTML(@content)
    end

    def title
      @title ||= @doc.at(".text_title").text
    end

    def body
      @body ||= @doc.search("td .text_std")[6].inner_html
    end

    def composer
      @composer ||= @doc.search("td .text_std")[9].text
    end

    def artist
      @artist ||= @doc.search("td .text_std")[8].text
    end
    
  end
end
