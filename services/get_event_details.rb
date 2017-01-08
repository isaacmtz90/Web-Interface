# frozen_string_literal: true

# Gets list of all groups from API
class GetEventDetails
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    result = HTTP.get("#{EventsLocatorInterface.api_ver_url}/events/by_id/#{params[:id]}")
    Right(EventRepresenter.new(Event.new).from_json(result.body.to_s))
  rescue =>err
    puts err
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
