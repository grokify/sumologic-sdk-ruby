require './test/test_helper.rb'

require 'sumologic'

class SumoLogicTest < Test::Unit::TestCase
  def testSetup

    client = SumoLogic::Client.new(
      'myAccessId',
      'myAccessKey'
    )

    assert_equal "SumoLogic::Client", client.class.name

  end
end