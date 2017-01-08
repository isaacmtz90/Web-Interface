# frozen_string_literal: true
# class
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :check_input_valid, lambda { |param|
    keyword = param[:search_keyword]
    if keyword.nil? || keyword.empty?
      Left(Error.new('Please enter a valid search'))
    else
      Right(param)
    end
  }
  register :get_search_results, lambda { |param|
    puts param
    city = param[:city_id]
    keyword = param[:search_keyword]
    results =
      HTTP.get("#{EventsLocatorInterface.api_ver_url}/events/search/#{city}/#{keyword}")
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
