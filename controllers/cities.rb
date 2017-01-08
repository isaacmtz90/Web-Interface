# Handle everything related to cities
class EventsLocatorInterface < Sinatra::Base
  post '/add_city/?' do
    url_request = CityRequest.call(params)
    result = CreateCity.call(url_request)
    if result.success?
      flash[:notice] = 'The City and Events will be available soon!'
      redirect '/'
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
