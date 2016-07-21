require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Letra do
  before(:each) do
    @content = File.open(File.join(File.dirname(__FILE__), 'fixtures', 'siete_palabras.htm'), 'r:ISO-8859-1').read
    @letra = Letra.new(@content)
  end

  it 'should be started with the html content' do
    expect(@letra.content.size).to eql 71_004
  end

  it 'should have a title' do
    expect(@letra.title).to eql 'Siete Palabras'
  end

  it 'should have a body' do
    expect(@letra.body.scan(/y q sabe y no sabe nada,<br>/)[0]).to eql 'y q sabe y no sabe nada,<br>'
  end

  it 'chould have a composer' do
    expect(@letra.composer).to eql 'Kaleth Morales'
  end

  it 'should have an artist' do
    expect(@letra.artist).to eql 'Kaleth Morales'
  end
end
