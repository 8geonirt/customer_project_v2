require 'test_helper'

class SettingsTest < ActiveSupport::TestCase


  def setup
    @setting1 = Setting.new(name: "review_available", value: "true")
  end

end
