# If you want to change the default rails environment
# ENV['RAILS_ENV'] ||= 'your_env'

# Load the plugin testing framework
require 'rubygems'
$LOAD_PATH << File.expand_path(File.join(
    File.dirname(__FILE__), '..', '..', 'plugin_test_helper', 'lib'))
require 'plugin_test_helper'

require 'plugin_test_helper'

# Run the migrations (optional)
# ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
