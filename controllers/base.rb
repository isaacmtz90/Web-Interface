# frozen_string_literal: true

# frozen_string_literal: true
configure :development do
  def reload!
    # Tux reloading: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

require 'sinatra'
require 'econfig'
require 'slim'

# Main class
class EventsLocatorInterface < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end

  use Rack::Session::Cookie, secret: EventsLocatorInterface.config.SECRET
  use Rack::Flash

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end

  def self.api_ver_url
    [config.API_SERVER, config.API_VER].join('/')
  end

  def self.maps_api_key
    config.MAPS_API_KEY
  end
end
