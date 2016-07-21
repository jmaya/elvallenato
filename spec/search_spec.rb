require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Search do
  before(:each) do
    @search_content = File.open(File.join(File.dirname(__FILE__), 'fixtures', 'diomedes_search.htm'), 'r:ISO-8859-1').read
    @letra_content = File.open(File.join(File.dirname(__FILE__), 'fixtures', 'siete_palabras.htm'), 'r:ISO-8859-1').read
    allow(OpenURI).to receive(:open_uri).and_return(StringIO.new(@search_content))
    @search = Search.new('canta', 'Diomedes')
  end

  it 'should initialize with a mode and a term' do
    expect(Search.new('canta', 'Diomedes').term).to eql'Diomedes'
  end

  it 'should generate the right url' do
    expect(@search.url).to eql 'http://www.elvallenato.com/letras/busqueda.php?x=Diomedes&busca=canta&image.x=12&image.y=11'
  end

  it 'should deal with url query with spaces' do
    s = Search.new('canta', 'Diomedes Dias')
    expect(s.url).to eql 'http://www.elvallenato.com/letras/busqueda.php?x=Diomedes+Dias&busca=canta&image.x=12&image.y=11'
  end

  describe 'Load' do
    it 'should open the url and read the html to a local variable' do
      expect(@search.content.size).to eql 54_171
    end

    it 'should load the content only 1 time (we are using memoization)' do
      expect(OpenURI).to receive(:open_uri).exactly(1).times
      @search.content
      @search.content
      @search.content
    end
  end

  it 'should have n pages of searches' do
    expect(@search.pages).to eql 44
  end

  it 'should have a valid page' do
    (1..44).each do |t|
      expect(@search.next_url).to eql "http://www.elvallenato.com/busqueda.php?x=Diomedes&busca=canta&pg=#{t}"
    end
    # the next one should be nil
    expect(@search.next_url).to be_nil
  end

  it 'should clean the url' do
    expect(@search.liric_links[0]).to eql 'http://www.elvallenato.com/letras/letras/1948/La+irremplazable-Diomedes+Diaz+Maestre-Edilberto+Daza.htm'
  end

  it 'should collect lirics' do
    expect(@search.letras.size).to eql 20
  end
end
