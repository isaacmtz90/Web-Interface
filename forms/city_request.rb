# frozen_string_literal: true

CityRequest = Dry::Validation.Form do
  required(:city_name).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end
