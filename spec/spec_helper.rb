require 'rubygems'
require 'bundler/setup'

require 'combustion'

Combustion.initialize! :action_view, :action_mailer, :active_record, :sprockets

require 'rspec/rails'

# RSpec.configure do |config|
#   config.use_transactional_fixtures = true
# end
