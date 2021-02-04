# frozen_string_literal: true

# Takes a string and validates against the allowed format of UK postcodes
# Taken from https://ideal-postcodes.co.uk/guides/uk-postcode-format
module Postcodes
  class Validator
    def initialize(postcode:)
      @postcode = postcode.gsub(/[^0-9a-z]/i, '') # remove non alpha-numeric
    end

    def valid?
      postcode_is_right_length? && end_is_right_format? && starts_with_a_letter?
    end

    private

    attr_reader :postcode

    def postcode_is_right_length?
      postcode.chars.size.between?(5, 7)
    end

    # format for last 3 characters must be Digit - Character - Character
    def end_is_right_format?
      postcode[-3].match?(/[[:digit:]]/) &&
        within_a_to_z?(letter: postcode[-2]) &&
        within_a_to_z?(letter: postcode[-1])
    end

    def starts_with_a_letter?
      within_a_to_z?(letter: postcode[0])
    end

    def within_a_to_z?(letter:)
      letter.match?(/[[:alpha:]]/)
    end
  end
end
