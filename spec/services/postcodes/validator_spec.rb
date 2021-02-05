# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Postcodes::Validator do
  describe '#initialize' do
    it 'does not error when the string is empty' do
      empty_string = ''
      validator = described_class.new(postcode: empty_string)

      expect(validator.instance_variable_get(:@postcode)).to eq ''
    end
  end

  describe '#valid?' do
    context 'with a valid postcode' do
      it 'accepts postcodes of the format AA9A9AA' do
        expect(valid?(postcode: 'AA9A9AA')).to be_truthy
      end

      it 'accepts postcodes of the format A9A9AA' do
        expect(valid?(postcode: 'A9A9AA')).to be_truthy
      end

      it 'accepts postcodes of the format A99AA' do
        expect(valid?(postcode: 'A99AA')).to be_truthy
      end

      it 'accepts postcodes of the format A999AA' do
        expect(valid?(postcode: 'A999AA')).to be_truthy
      end

      it 'accepts postcodes of the format AA99AA' do
        expect(valid?(postcode: 'AA99AA')).to be_truthy
      end

      it 'accepts postcodes of the format AA999AA' do
        expect(valid?(postcode: 'AA999AA')).to be_truthy
      end
    end

    context 'with an invalid postcode' do
      it 'rejects when the first character is not a letter' do
        expect(valid?(postcode: '9A99 9AA')).not_to be_truthy
      end

      it 'returns false when the postcode is too short' do
        expect(valid?(postcode: 'A9AA')).not_to be_truthy
      end

      it 'returns false when the postcode is too long' do
        expect(valid?(postcode: 'AA99 99AA')).not_to be_truthy
      end

      it 'returns false when it does not end with an integer and two letters' do
        expect(valid?(postcode: 'AA99 99A')).not_to be_truthy
      end

      it 'returns false when the string is empty' do
        expect(valid?(postcode: '')).not_to be_truthy
      end
    end
  end

  def valid?(postcode:)
    described_class.new(postcode: postcode).valid?
  end
end
