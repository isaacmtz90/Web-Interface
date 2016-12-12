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
      @browser.seachbox.placeholder 'Enter a City...' #TODO: change test
      @browser.searchBtn.type 'submit' #TODO: change test
      @browser.aroundMeBtn.type 'submit' #TODO: change test

      # THEN
      @browser.button(name: 'new_group').visible?.must_equal true #TODO: change test
    end


end
