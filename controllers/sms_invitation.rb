# Handle everything related to cities
class EventsLocatorInterface < Sinatra::Base
  post '/send_sms/?' do
    url_request = SmsRequest.call(params)
    result = CreateSmsInvitation.call(url_request)
    if result.success?
      flash[:notice] = 'Your invitation will be sent soon!'
      redirect '/'
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
