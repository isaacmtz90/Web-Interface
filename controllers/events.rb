class EventsLocator_Interface < Sinatra::Base
  # Web Interface front page
  get '/?' do
    # TODO: build the view!
    slim :events
  end
end
