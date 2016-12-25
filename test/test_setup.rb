require './test/test_helper.rb'

require 'sumologic'

class SumoLogicTest < Test::Unit::TestCase
  def test_setup

    client = SumoLogic::Client.new(
      'myAccessId',
      'myAccessKey'
    )

    assert_equal "SumoLogic::Client", client.class.name

  end
end