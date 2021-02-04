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
    context 'when the postcode is not valid' do
      before do
        invalid_postcode = 'B 123'
        postcode_validator = instance_double('PostcodeValidator', valid?: false)
        allow(Postcodes::Validator).to receive(:new).with(postcode: invalid_postcode).and_return postcode_validator
        post :create, params: { postcode_checker_index: { postcode: invalid_postcode } }
      end

      it 'renders the invalid_postcode template' do
        expect(response).to render_template(:invalid_postcode)
      end

      it 'returns a status code of 200' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
