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
end
