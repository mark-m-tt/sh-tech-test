# frozen_string_literal: true

require 'rails_helper'
require './spec/support/io_api_response'

RSpec.describe Postcodes::IoApi do
  include IoApiResponse

  describe '#data' do
    it 'returns the raw HTTP response from the Postcodes IO Api' do
      test_postcode = 'SW1A2AA'
      expected = api_response
      expect(described_class.new(postcode: test_postcode).data).to eq expected
    end
  end

  describe '#perform' do
    it 'returns the data in an appropriate format' do
      test_postcode = 'SW1A2AA'
      expected_response = {
        status: 200,
        postcode: 'SW1A 2AA',
        lsoa: 'Westminster 018C'
      }
      expect(described_class.new(postcode: test_postcode).perform).to eq expected_response
    end
  end
end
