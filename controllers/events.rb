# Class to retreieve the events from a city
class EventsLocatorInterface < Sinatra::Base
  # Web Interface front page
  get '/?' do
    flash[:search_keyword] = ''
    result = GetAllCities.call
    if result.success?
      @cities = result.value.cities
    else
      flash[:error] = result.value.message
    end
    slim :city_search
  end

  get '/search' do
    cities = GetAllCities.call
    if cities.success?
      @cities = cities.value.cities
    else
      flash[:error] = cities.value.message
    end
    result = SearchEvents.call(params)

    if result.success?
      flash[:search_keyword] = params['search_keyword']
      flash[:selected_city] = params['city_id']
      @event_results = result.value.events
      slim :events_result
    else
      flash[:error] = result.value.message.to_s
      redirect '/'
    end
  end

  get '/event/:id' do
    event_details = GetEventDetails.call(params)
    if event_details.success?
      # puts event_details.value.from_json
      @event = event_details.value
      puts @event
      slim :event_landing
    else
      flash[:error] = 'Could not find that event --Maybe they dont want to invite you?'
      redirect '/'
    end
  end

  get '/around' do
    result = SearchEvents.call(params[:search_keyword])
    if result.success?
      @event_results = result.value.events
      slim :around_me_result
    else
      flash[:error] = result.value.code
      redirect '/'
    end
  end
end
