# frozen_string_literal: true

# This class takes a as of postcode data and checks this
# Against a pre-configered list of allowed postcodes and
# LSOA's
module Postcodes
  class LocationChecker
    ALLOWED_LSOAS = %w[Lambeth Southwark].freeze
    ALLOWED_POSTCODES = %w[SH241AA SH241AB].freeze

    def initialize(postcode:, api_client: IoApi)
      @api_client = api_client
      @postcode = postcode
    end

    def location_is_served?
      ALLOWED_POSTCODES.include?(postcode) || ALLOWED_LSOAS.include?(lsoa)
    end

    private

    attr_accessor :api_client, :postcode

    def postcode_data
      @postcode_data ||= api_client.new(postcode: postcode).data
    end

    def lsoa
      return nil unless postcode_data['status'] == 200

      postcode_data['result']['lsoa'].split.first
    end
  end
end
