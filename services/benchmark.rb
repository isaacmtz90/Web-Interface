require 'concurrent'
require 'benchmark'

class Benchmark_Concurrency
  def self.cities_with_promise()
    Benchmark.measure do
      updates = 5.times.map do
        Concurrent::Promise.execute { HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/cities") }
      end
      updates.map { |update| update.value }
    end.real
  end

  def self.cities_no_promise()
    Benchmark.measure do
      5.times.map {HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/cities")}
    end.real
  end


def self.events_with_promise()
  Benchmark.measure do
    updates = 5.times.map do
      Concurrent::Promise.execute { HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/city/1/events") }
    end
    updates.map { |update| update.value }
  end.real
end

def self.events_no_promise()
  Benchmark.measure do
    5.times.map {HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/city/1/events")}
  end.real
end
end


# HOW TO RUN:
# => rackup Web_API
# => tux Web-Interface
# => $ Benchmark_Concurrency.cities_with_promise
# => $ Benchmark_Concurrency.cities_no_promise
