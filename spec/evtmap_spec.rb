# frozen_string_literal: true
require_relative 'spec_helper'

describe 'EvtMap Tests' do
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

  describe 'Test Page Elements' do
    it '(HAPPY) should see website features' do
      @browser.goto "http://evtmap.herokuapp.com/"

      @browser.text_field(:placeholder => "Search for a topic (i.e 'Python')").visible?.must_equal true
      @browser.button(:index => 0).visible?.must_equal true   #search button
      @browser.button(:index => 1).visible?.must_equal true   #aroundme button
    end

    it '(HAPPY) should go to next page and see features' do
      @browser.goto "http://evtmap.herokuapp.com/"

      @browser.text_field(:placeholder => "Search for a topic (i.e 'Python')").set "python"
      @browser.button(:index => 0).click   #search button
      #@browser.button(:index => 2).visible?.must_equal true #seemore button
      #@browser.button(:index => 3).visible?.must_equal true #notifyme button
      @browser.button(:text => "Close").visible?.must_equal false
      #@browser.link(:text =>"See more").when_present.click
      #@browser.button(:text => "Close").when_present.click
    end

    it '(HAPPY) should go to next page and see features' do
      @browser.goto "http://evtmap.herokuapp.com/"

      @browser.text_field(:placeholder => "Search for a topic (i.e 'Python')").set "python"
      @browser.button(:index => 0).click
      @browser.link(:text =>"See more").wait_until_present.click
      @browser.button(:text => "Close").wait_until_present.click
    end
  end
end
