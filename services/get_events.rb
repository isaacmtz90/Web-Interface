# frozen_string_literal: true
# class
class GetEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  register :check_input_valid, lambda { |param|
    if param[:search_keyword].empty?
      Left(Error.new(:cannot_process, 'Please enter a valid search'))
    else
      Right(param[:search_keyword])
    end
  }
  register :retrieve_events_from_api, lambda { |city_id|
    results = HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/city/#{city_id}/events")
    if results.empty? == False
      Right(EventsRepresenter.new(Events.new)
                           .from_json(results.body))
    else
      Left(Error.new(:internal_error, 'Our servers failed - we are investigating!'))
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :check_input_valid
      step :retrieve_events_from_api
    end.call(params)
  end
end
