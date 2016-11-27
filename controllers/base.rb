# frozen_string_literal: true
require 'sinatra'
require 'econfig'
require 'slim'

# Main class
class EventsLocator_Interface < Sinatra::Base
  extend Econfig::Shortcut

  Econfig.env = settings.environment.to_s
  Econfig.root = settings.root

  #use Rack::Session::Cookie, secret: EventsLocator_Interface.config.SECRET
  #use Rack::Flash

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end
end
