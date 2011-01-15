require 'rubygems'
require 'nokogiri'
require 'redcloth'

module ElVallenato

end

Dir.glob(File.expand_path(File.dirname(__FILE__) + '/elvallenato') + "/*.rb").each do |rb|
  require rb
end

