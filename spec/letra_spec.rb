# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Letra do
  before(:each) do
    @content = File.read(File.join(File.dirname(__FILE__), "fixtures", "siete_palabras.htm"))
    @l = Letra.new(@content)
  end
  
  it "should be started with the html content" do
    l = Letra.new(@content)
    l.content.size.should eql 71004
  end

  it "should have a title" do
    @l.title.should eql "Siete Palabras"
  end
  
  it "should have a body" do
    @l.body.scan(/y q sabe y no sabe nada,/)[0].should eql "y q sabe y no sabe nada,"
  end
  
end
