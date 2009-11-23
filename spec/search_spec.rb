require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Search do
  before(:each) do
    @s = Search.new("canta", "Diomedes")
    @search_content = File.join(File.dirname(__FILE__), "fixtures", "diomedes_search.htm")
    @s.load_content = (File.read(@search_content))
  end
  
  it "should state cantante compositor clave the type and the search" do
    #http://www.elvallenato.com/letras/busqueda.php?x=&busca=canta&image.x=8&image.y=6
    s = Search.new("canta", "Diomedes Diaz")
  end

  it "should generate the right url" do
    s = Search.new("canta", "")
    s.url.should eql "http://www.elvallenato.com/letras/busqueda.php?x=&busca=canta&image.x=8&image.y=6"
  end

  it "should generate the right url with query" do
    s = Search.new("canta", "Diomedes")
    s.url.should eql "http://www.elvallenato.com/letras/busqueda.php?x=Diomedes&busca=canta&image.x=12&image.y=11"
  end

  it "should deal with url query with spaces" do
    s = Search.new("canta", "Diomedes Dias")
    s.url.should eql "http://www.elvallenato.com/letras/busqueda.php?x=Diomedes+Dias&busca=canta&image.x=12&image.y=11"
  end
  it "should load content from a string" do
    @s.load_content.size.should eql 54171
  end
  
  it "should have a valid page" do
    @s.next_url.should eql "http://www.elvallenato.com/letras/busqueda.php?x=Diomedes&busca=canta&pg=1"
  end

  it "should collect links" do
    @s.collect_links.size.should eql 20
  end

  it "should generate liric objects from the links" do
    @s.collect_lirics.size.should eql 20
  end
end
