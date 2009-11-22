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
    @doc./("td .text_std")[6].inner_html.gsub(/<br \/>/, "\n")
  end
end
