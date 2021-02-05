# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  def index; end

  def create
    return render :invalid_postcode, status: :unprocessable_entity unless postcode_is_valid?

    render :show, locals: { postcode_is_served: postcode_is_served? }
  end

  private

  def postcode
    params[:postcode_checker_index][:postcode].gsub(/[^0-9a-z]/i, '') # remove non alpha-numeric
  end

  def postcode_is_valid?
    Postcodes::Validator.new(postcode: postcode).valid?
  end

  def postcode_is_served?
    Postcodes::LocationChecker.new(postcode: postcode).location_is_served?
  end
end
