# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeCheckerController, type: :controller do
  describe 'GET index' do
    it 'renders the index page' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'returns a status code of 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    render_views

    context 'when the postcode is not valid' do
      let(:invalid_postcode) { 'InvalidPostcode' }

      before do
        mock_validator(postcode: invalid_postcode, valid: false)
        post :create, params: { postcode_checker_index: { postcode: invalid_postcode } }
      end

      it 'calls the Postcodes::Validator service' do
        expect(Postcodes::Validator).to have_received(:new).with(postcode: invalid_postcode)
      end

      it 'renders the invalid_postcode template' do
        expect(response).to render_template(:invalid_postcode)
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders an appropriate error message' do
        expect(response.body).to include('This postcode is invalid, please try again')
      end
    end

    context 'when the postcode is valid and served' do
      let(:served_postcode) { 'SE17QD' }

      before do
        mock_validator(postcode: served_postcode, valid: true)
        mock_location_checker(postcode: served_postcode, served: true)
        post :create, params: { postcode_checker_index: { postcode: served_postcode } }
      end

      it 'calls the location_checker' do
        expect(Postcodes::LocationChecker).to have_received(:new).with(postcode: served_postcode)
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'renders the appropriate message' do
        expect(response.body).to include('Great news, we serve your area!')
      end
    end

    context 'when the postcode is valid but not served' do
      let(:valid_unserved_postcode) { 'BS87QD' }

      before do
        mock_validator(postcode: valid_unserved_postcode, valid: true)
        mock_location_checker(postcode: valid_unserved_postcode, served: false)
        post :create, params: { postcode_checker_index: { postcode: valid_unserved_postcode } }
      end

      it 'calls the location_checker' do
        expect(Postcodes::LocationChecker).to have_received(:new).with(postcode: valid_unserved_postcode)
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'renders the appropriate message' do
        expect(response.body).to include("We're sorry but we don't serve your area at the moment")
      end
    end
  end

  def mock_validator(postcode:, valid:)
    postcode_validator = instance_double('Postcodes::Validator', valid?: valid)
    allow(Postcodes::Validator).to receive(:new).with(postcode: postcode).and_return postcode_validator
  end

  def mock_location_checker(postcode:, served:)
    location_checker = instance_double('Postcodes::LocationChecker', location_is_served?: served)
    allow(Postcodes::LocationChecker).to receive(:new).with(postcode: postcode).and_return location_checker
  end
end
