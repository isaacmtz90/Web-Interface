# frozen_string_literal: true
SmsRequest = Dry::Validation.Form do
  PHONE_REGEX = /\d{9,10}/
  required(:input_name).filled
  required(:input_phone).filled(format?: PHONE_REGEX)
  required(:event_name).filled
  required(:event_id).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/sms_request.yml')
  end
end
