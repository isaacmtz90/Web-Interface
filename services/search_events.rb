# frozen_string_literal: true
# class
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :check_input_valid, lambda { |param|

    if param.nil? || param.empty?
      Left(Error.new('Please enter a valid search'))
    else
      Right(param)
    end
  }
  register :get_search_results, lambda { |term|
    results =
      HTTP.get("#{EventsLocatorInterface.api_ver_url}/events/search/#{term}")
    if results.status >= 400
      Left(Error.new('Seems like we dont have events related to your search, try something different'))
    else
      Right(EventsRepresenter.new(Events.new)
                             .from_json(results.body))
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :check_input_valid
      step :get_search_results
    end.call(params)
  end
end
