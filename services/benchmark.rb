require 'concurrent'
require 'benchmark'

class Benchmark_Concurrency
  def self.cities_with_promise()
    Benchmark.measure {
      Concurrent::Promise.execute { results = HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/cities") }
    }.real
  end

  def self.call_no_promise()
    Benchmark.measure { results = HTTP.get("#{EventsLocatorInterface.config.WEB_API_URL}/cities")
  }.real
  end
end

# HOW TO RUN:
# => rackup Web_API
# => tux Web-Interface
# => $ Benchmark_Concurrency.cities_with_promise
# => $ Benchmark_Concurrency.cities_no_promise
