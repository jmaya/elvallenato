require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Search do
  before(:each) do
    @search_content = File.open(File.join(File.dirname(__FILE__), "fixtures", "diomedes_search.htm"),'r:ISO-8859-1').read
    @letra_content = File.open(File.join(File.dirname(__FILE__), "fixtures", "siete_palabras.htm"),'r:ISO-8859-1').read
    OpenURI.stub!(:open_uri).and_return(StringIO.new(@search_content))
    @search = Search.new('canta', 'Diomedes')
  end

  it "should initialize with a mode and a term" do
    Search.new("canta", "Diomedes").term.should == "Diomedes"
  end

  it "should generate the right url" do
    @search.url.should == "http://www.elvallenato.com/letras/busqueda.php?x=Diomedes&busca=canta&image.x=12&image.y=11"
  end
  it "should deal with url query with spaces" do
    s = Search.new("canta", "Diomedes Dias")
    s.url.should eql "http://www.elvallenato.com/letras/busqueda.php?x=Diomedes+Dias&busca=canta&image.x=12&image.y=11"
  end

  describe "Load" do
    it "should open the url and read the html to a local variable" do
      @search.content.size.should == 54171
    end

    it "should load the content only 1 time (we are using memoization)" do
      OpenURI.should_receive(:open_uri).exactly(1).times
      @search.content
      @search.content
      @search.content
    end
  end

  it "should have n pages of searches" do
    @search.pages.should == 44
  end

  it "should have a valid page" do
    (1..44).each do |t|
      @search.next_url.should eql "http://www.elvallenato.com/busqueda.php?x=Diomedes&busca=canta&pg=#{t}"
    end
    #the next one should be nil
    @search.next_url.should be_nil
  end

  it "should clean the url" do
    @search.liric_links[0].should == "http://www.elvallenato.com/letras/letras/1948/La+irremplazable-Diomedes+Diaz+Maestre-Edilberto+Daza.htm"
  end

  it "should collect lirics" do
    @search.letras.size.should eql 20
  end
end
