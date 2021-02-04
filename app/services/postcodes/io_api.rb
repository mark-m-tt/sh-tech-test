# frozen_string_literal: true

# API Client for postcodes.io, docs: http://postcodes.io/
module Postcodes
  class IoApi
    API_BASE_URL = 'https://api.postcodes.io/'
    GET_POSTCODE_URL = "#{API_BASE_URL}/postcodes/"

    def initialize(postcode:)
      @postcode = postcode
    end

    def data_for_postcode
      HTTParty.get("#{GET_POSTCODE_URL}#{postcode}").parsed_response
    end

    private

    attr_reader :postcode
  end
end
