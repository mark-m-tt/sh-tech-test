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
end
