# frozen_string_literal: true

require "flights/base"

module Flights
  class Common < Base
    def initialize(_weight, _route)
      @weight = _weight.freeze
      raise ArgumentError, "Invalid route" if _route.size < 2

      @route = _route.freeze
    end

    attr_reader :route

    def middleware
      @ops = [[:launch, route.last]] +
             route[1..-2].flat_map { |pl| [[:land, pl], [:launch, pl]] } +
             [[:land, route.last]]
    end
  end
end
