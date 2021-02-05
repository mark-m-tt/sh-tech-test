# frozen_string_literal: true

module InstanceDoubleMethods
  def double_validator(postcode:, valid:)
    postcode_validator = instance_double('Postcodes::Validator', valid?: valid)
    allow(Postcodes::Validator)
      .to receive(:new)
      .with(postcode: postcode.gsub(/[^0-9a-z]/i, ''))
      .and_return postcode_validator
  end

  def double_location_checker(postcode:, served:)
    location_checker = instance_double('Postcodes::LocationChecker', location_is_served?: served)
    allow(Postcodes::LocationChecker)
      .to receive(:new)
      .with(postcode: postcode.gsub(/[^0-9a-z]/i, ''))
      .and_return location_checker
  end
end
