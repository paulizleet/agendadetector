require_relative 'boot'

#require 'rails/all'

#Framework for MongoMapper
require "action_controller/railtie"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



module AgendaDetector
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #commented for MongoDB to work
    #config.active_job.queue_adapter = :delayed_job

    #Handler for invalid routes
    config.exceptions_app = self.routes
    
    #Create generators for mongo stuff
    config.generators do |g|
      g.orm :mongo_mapper
    end
  end
end
