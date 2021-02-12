# frozen_string_literal: true

require 'rails_helper'
require './spec/support/io_api_response'

RSpec.describe Postcodes::DummyApi do
  describe '#perform' do
    it 'returns the dummy response' do
      expected_response = {
        status: 'ok',
        postcode: 'SE1 7JB',
        lsoa: 'Lambeth'
      }

      expect(described_class.new(postcode: 'anything').perform).to eq expected_response
    end
  end
end
