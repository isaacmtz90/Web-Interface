# frozen_string_literal: true

Event = Struct.new :id, :city_id, :event_name, :url, :origin, :status, :venue,
                   :lat, :lon, :topic, :time
