require 'autotest/growl'
require 'autotest/fsevent'
Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |autotest|
  %w{webrat.log .git .svn .hg .DS_Store tmp log doc}.each do |exception|
    autotest.add_exception(exception)
  end
end
