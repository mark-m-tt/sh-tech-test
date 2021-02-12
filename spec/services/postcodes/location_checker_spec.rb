# frozen_string_literal: true

require 'rails_helper'
require './spec/support/io_api_response'

RSpec.describe Postcodes::LocationChecker do
  include IoApiResponse

  describe '#location_is_served' do
    context 'when the postcode belongs on the allowed list' do
      it 'returns true for SH241AA' do
        expect(described_class.new(postcode: 'SH241AA')).to be_location_is_served
      end

      it 'returns true for SH241AB' do
        expect(described_class.new(postcode: 'SH241AB')).to be_location_is_served
      end
    end

    it "returns true when the postcode's LSOA is on the allowed list" do
      api_response_instance = instance_double('Postcodes::IoApi', data: dummy_lambeth_response)
      allow(Postcodes::IoApi).to receive(:new).with(postcode: 'postcode_in_lambeth').and_return api_response_instance
      allow(api_response_instance).to receive(:perform).and_return({ lsoa: 'Lambeth' })
      expect(described_class.new(postcode: 'postcode_in_lambeth')).to be_location_is_served
    end

    it 'returns false if the postcode and related LSOA are not on the allowed list' do
      api_response_instance = instance_double('Postcodes::IoApi', data: dummy_hounslow_response)
      allow(Postcodes::IoApi).to receive(:new).with(postcode: 'postcode_in_hounslow').and_return api_response_instance
      allow(Postcodes::DummyApi)
        .to receive(:new)
        .with(postcode: 'postcode_in_hounslow')
        .and_return api_response_instance
      allow(api_response_instance).to receive(:perform).and_return({ lsoa: 'Hounslow' })
      expect(described_class.new(postcode: 'postcode_in_hounslow')).not_to be_location_is_served
    end
  end
end
