# frozen_string_literal: true

# Represents overall event information for JSON API output
class CityRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :country_code
  property :name
  property :lat
  property :lon
end
