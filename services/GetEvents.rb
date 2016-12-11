# frozen_string_literal: true
# class
class GetAllCities
  extend Dry::Monads::Either::Mixin

  def self.call(city_id)
    results = HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/city/#{city_id}/events")
    Right(EventsRepresenter.new(Events.new)
                           .from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
