# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeValidator do
  describe '#initialize' do
    it 'strips the given postcode of non alphanumeric characters and adds a space where required' do
      postcode = 'AA9A%^*£"$$"9AA'
      validator = described_class.new(postcode: postcode)

      expect(validator.instance_variable_get(:@postcode)).to eq 'AA9A 9AA'
    end

    it 'does not error when the string is empty' do
      empty_string = ''
      validator = described_class.new(postcode: empty_string)

      expect(validator.instance_variable_get(:@postcode)).to eq ''
    end
  end

  describe '#valid?' do
    context 'with a valid postcode' do
      it 'accepts postcodes of the format AA9A 9AA' do
        expect(valid?(postcode: 'AA9A 9AA')).to be_truthy
      end

      it 'accepts postcodes of the format A9A 9AA' do
        expect(valid?(postcode: 'A9A 9AA')).to be_truthy
      end

      it 'accepts postcodes of the format A9 9AA' do
        expect(valid?(postcode: 'A9 9AA')).to be_truthy
      end

      it 'accepts postcodes of the format A99 9AA' do
        expect(valid?(postcode: 'A99 9AA')).to be_truthy
      end

      it 'accepts postcodes of the format AA9 9AA' do
        expect(valid?(postcode: 'AA9 9AA')).to be_truthy
      end

      it 'accepts postcodes of the format AA99 9AA' do
        expect(valid?(postcode: 'AA99 9AA')).to be_truthy
      end
    end

    context 'with an invalid postcode' do
      it 'rejects when the first character is not a letter' do
        expect(valid?(postcode: '9A99 9AA')).not_to be_truthy
      end

      it 'returns false when the postcode is too short' do
        expect(valid?(postcode: 'A 9AA')).not_to be_truthy
      end

      it 'returns false when the postcode is too long' do
        expect(valid?(postcode: 'AA99 99AA')).not_to be_truthy
      end

      it 'returns false when it does not end with an integer and two letters' do
        expect(valid?(postcode: 'AA99 99A')).not_to be_truthy
      end
    end
  end

  def valid?(postcode:)
    described_class.new(postcode: postcode).valid?
  end
end
