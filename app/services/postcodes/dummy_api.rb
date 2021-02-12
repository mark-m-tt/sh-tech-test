# frozen_string_literal: true

module Postcodes
  class DummyApi
    def initialize(postcode:)
      @postcode = postcode
    end

    def perform
      {
        status: dummy_response[:status],
        postcode: dummy_response[:results].first[:postcode],
        lsoa: dummy_response[:results].first[:region]
      }
    end

    private

    def dummy_response # rubocop:disable Metrics/MethodLength
      {
        pagination: {
          page: 1,
          total_pages: 1,
          per_page: 20
        },
        results: [{
          postcode: 'SE1 7JB',
          region: 'Lambeth'
        }],
        status: 'ok'
      }
    end
  end
end
