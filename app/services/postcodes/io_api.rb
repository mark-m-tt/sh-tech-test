# frozen_string_literal: true

# API Client for postcodes.io, docs: http://postcodes.io/
module Postcodes
  class IoApi
    API_BASE_URL = 'https://api.postcodes.io'
    GET_POSTCODE_URL = '/postcodes/'
    ALLOWED_LSOAS = %w[Lambeth Southwark].freeze

    def initialize(postcode:)
      @postcode = postcode
    end

    def perform
      {
        status: status,
        postcode: postcode_result,
        lsoa: lsoa
      }
    end

    def data
      HTTParty.get("#{API_BASE_URL}#{GET_POSTCODE_URL}#{postcode}").parsed_response
    end

    private

    attr_reader :postcode

    def postcode_result
      data['result']['postcode']
    end

    def status
      data['status']
    end

    def lsoa
      data['result']['lsoa']
    end
  end
end
