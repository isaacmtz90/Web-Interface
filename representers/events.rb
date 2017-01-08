# frozen_string_literal: true
require_relative 'event'
require_relative 'city'

# Represents overall group information for JSON API output
class EventsRepresenter < Roar::Decorator
  include Roar::JSON
  collection :events, extend: EventRepresenter, class: Event
end
