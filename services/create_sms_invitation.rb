# frozen_string_literal: true

# Gets list of all groups from API
class CreateSmsInvitation
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_sms_request
      step :call_api_to_create_invitation
      step :return_api_result
    end.call(url_request)
  end

  register :validate_sms_request, lambda { |sms_request|
    if sms_request.success?
      from = sms_request[:input_name]
      to = sms_request[:input_phone]
      event_id = sms_request[:event_id]
      event_name = sms_request[:event_name]
      Right(from: from, to: to, event_name: event_name, event_id: event_id)
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_create_invitation, lambda { |params|
    begin
      Right(HTTP.post("#{EventsLocatorInterface.api_ver_url}/send_invitation",
                      json: params))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    if http_result.status < 400
      Right(data)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
end
