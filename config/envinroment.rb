# frozen_string_literal: true
require 'sinatra'

configure :development do
  ENV['WEB_API_URL'] = 'http://meetup-event-mapper.herokuapp.com/'
end

configure :test do
  ENV['WEB_API_URL'] = 'http://meetup-event-mapper.herokuapp.com/'
end

configure :production do
  ENV['WEB_API_URL'] = 'http://meetup-event-mapper.herokuapp.com/'
end
