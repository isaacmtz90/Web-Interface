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
      @browser.seachbox.placeholder 'Enter a City...' 
      @browser.searchBtn.type 'submit'
      @browser.aroundMeBtn.type 'submit'

      # THEN
      @browser.button(name: 'new_group').visible?.must_equal true
    end
  end
end
