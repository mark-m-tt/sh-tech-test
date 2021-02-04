# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  def index; end

  def create
    return render :invalid_postcode, status: :unprocessable_entity unless postcode_is_valid?

    render :index
  end

  private

  def postcode
    params[:postcode_checker_index][:postcode]
  end

  def postcode_is_valid?
    PostcodeValidator.new(postcode: postcode).valid?
  end
end
