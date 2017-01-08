# frozen_string_literal: true

# Gets list of all groups from API
class CreateCity
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_city_request
      step :call_api_to_create_city
      step :return_api_result
    end.call(url_request)
  end

  register :validate_city_request, lambda { |city_request|
    if city_request.success?
      Right(city_request[:city_name])
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_create_city, lambda { |city_name|
    begin
      Right(HTTP.post("#{EventsLocatorInterface.api_ver_url}/city",
                      json: { city: city_name, country_code: 'tw' }))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    if http_result.status == 202
      Right(data)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
