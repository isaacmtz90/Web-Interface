# frozen_string_literal: true

# Gets list of all groups from API
class GetAllCities
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/cities")
    Right(CitiesRepresenter.new(Cities.new)
                           .from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
