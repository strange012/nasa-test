# frozen_string_literal: true

require "json"

module Flights
  class Base
    class FlightError < StandardError; end

    class << self
      def call(*args)
        flight = new(*args)
        flight.middleware
        flight.call
      end

      private

      def read_json(name)
        JSON.parse(File.read(File.join(File.dirname(__FILE__), "../data/#{name}.json")), symbolize_names: true).freeze
      end
    end

    OPERATIONS = read_json(:operations)
    PLANETS = read_json(:planets)

    def initialize(_weight, _ops)
      @weight = _weight.freeze
      @ops = _ops.freeze
    end

    attr_reader :weight, :ops

    def middleware; end

    def call
      ops.reverse.reduce(weight) { |total, op| total + fuel_weight(total, operation(op[0]), planet(op[1])) } - weight
    end

    private

    def planet(name)
      PLANETS[name.to_sym] || (raise FlightError, "Unknown planet")
    end

    def operation(name)
      OPERATIONS[name.to_sym] || (raise FlightError, "Unknown operation")
    end

    def fuel_weight(total, op, planet)
      fuel_weight_step = lambda do |total|
        return 0 if total <= 0

        fuel = (op[:mult] * planet[:gravity] * total).to_i - op[:rem]
        total + fuel_weight_step.(fuel)
      end

      fuel_weight_step.(total) - total
    end
  end
end
