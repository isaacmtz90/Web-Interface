class EventsLocatorInterface < Sinatra::Base
  # Web Interface front page
  get '/?' do
    result = GetAllCities.call
    if result.success?
      @cities = result.value
      puts @cities
    else
      flash[:error] = result.value.messages_file
    end
    slim :city_search
  end

  get '/city/:id/?' do
    event_details = GetEvents.call(params)
    if event_details.success?
      events = event_details.value
      @event = EventDetailsView.new(events)
      slim :group_details
    else
      flash[:error] = 'Could not find that city -- we are investigating!'
      redirect '/'
    end
  end
end
