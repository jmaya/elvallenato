require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Letra do
  before(:each) do
    @content = File.open(File.join(File.dirname(__FILE__), "fixtures", "siete_palabras.htm"),'r:ISO-8859-1').read
    @letra = Letra.new(@content)
  end

  it "should be started with the html content" do
    @letra.content.size.should eql 71004
  end

  it "should have a title" do
    @letra.title.should eql "Siete Palabras"
  end

  it "should have a body" do
    @letra.body.scan(/y q sabe y no sabe nada,<br>/)[0].should == "y q sabe y no sabe nada,<br>"
  end

  it "chould have a composer" do
    @letra.composer.should eql "Kaleth Morales"
  end

  it "should have an artist" do
        @letra.artist.should eql "Kaleth Morales"
  end

end
