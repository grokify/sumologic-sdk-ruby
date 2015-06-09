require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'sumologic'

client = SumoLogic::Client.new(
  'myAccessId',
  'myAccessKey'
)