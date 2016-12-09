# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'Groupster' #TODO: change test
      @browser.h1.text.must_include 'Groupster' #TODO: change test

      # THEN
      @browser.button(name: 'new_group').visible?.must_equal true #TODO: change test
    end
end
