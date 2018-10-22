# frozen_string_literal: true

module SinatraMind
  class Player
    def get_input(input: nil)
      loop do
        input = input_to_array(input: input) unless input.is_a? Array
        break if good_input?(input: input)

        input = gets.chomp
      end

      input
    end

    def good_input?(input:)
      return false if input.nil? || input == false

      input = input_to_array(input: input) unless input.is_a?(Array)

      return false if input == false
      return false if input.size != 4
      return false if input.any? { |num| num < 1 || num > 6 }

      input
    end

    private

    def input_to_array(input:)
      return false if input.nil? || input == false

      input.split(//).map(&:to_i)
    end
  end
end
