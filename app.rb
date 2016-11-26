# frozen_string_literal: true
require 'sinatra'
require 'econfig'

# Main class
class EventsLocator_Interface < Sinatra::Base
  extend Econfig::Shortcut

  Econfig.env = settings.environment.to_s
  Econfig.root = settings.root

  # Web Interface front page
  get '/?' do
    # ...
  end
end
