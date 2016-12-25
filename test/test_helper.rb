require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'sumologic'

SumoLogic::Client.new 'myAccessId', 'myAccessKey'
