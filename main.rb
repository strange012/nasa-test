# frozen_string_literal: true

$LOAD_PATH.unshift(
  File.expand_path(".", __dir__)
)

require "flights/common"

weight = ARGV[0].to_i
raise ArgumentError, "Invalid weight value" if weight <= 0

route = ARGV[1..-1]

puts Flights::Common.call(weight, route)
