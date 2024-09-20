require_relative 'boot'

# Instead of 'rails/all', explicitly require only the needed railties:
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"   # Explicitly load ActionController
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module LibraryManagementSystem
  class Application < Rails::Application
    config.load_defaults 6.0
    # config.raise_on_missing_callback_actions = true
    config.autoload_paths += %W(#{config.root}/src/controller #{config.root}/src/model)
  end
end
