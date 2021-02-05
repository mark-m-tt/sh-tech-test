# frozen_string_literal: true

require 'rails_helper'
require './spec/support/instance_double_methods'

RSpec.describe PostcodeCheckerController, type: :controller do
  include InstanceDoubleMethods
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
        double_validator(postcode: invalid_postcode, valid: false)
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
      let(:served_postcode) { 'SE1 7QD' }

      before do
        double_validator(postcode: served_postcode, valid: true)
        double_location_checker(postcode: served_postcode, served: true)
        post :create, params: { postcode_checker_index: { postcode: served_postcode } }
      end

      it 'calls the location_checker' do
        expect(Postcodes::LocationChecker).to have_received(:new)
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
      let(:valid_unserved_postcode) { 'BS8 7QD' }

      before do
        double_validator(postcode: valid_unserved_postcode, valid: true)
        double_location_checker(postcode: valid_unserved_postcode, served: false)
        post :create, params: { postcode_checker_index: { postcode: valid_unserved_postcode } }
      end

      it 'calls the location_checker' do
        expect(Postcodes::LocationChecker).to have_received(:new)
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
end
