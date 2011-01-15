$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'elvallenato'
require 'rspec'
require 'rspec/autorun'

include ElVallenato

Spec::Runner.configure do |config|
  
end
