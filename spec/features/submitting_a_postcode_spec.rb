# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'submitting a postcode', type: :feature do
  include InstanceDoubleMethods

  it 'renders the appropriate message when the postcode is invalid' do
    visit '/'
    fill_in 'postcode_checker_index_postcode', with: 'Invalid Postcode'
    click_button 'Check'
    expect(page).to have_content 'This postcode is invalid, please try again'
  end

  it 'renders the appropriate message when the postcode is valid and not served' do
    valid_unserved_postcode = 'BS8 2DD'
    visit '/'
    fill_in 'postcode_checker_index_postcode', with: valid_unserved_postcode
    double_location_checker(postcode: valid_unserved_postcode, served: false)
    click_button 'Check'
    expect(page).to have_content "We're sorry but we don't serve your area at the moment"
  end

  it 'renders the appropriate message when the postcode is valid and served' do
    valid_served_postcode = 'SH24 1AA'
    visit '/'
    fill_in 'postcode_checker_index_postcode', with: valid_served_postcode
    double_location_checker(postcode: valid_served_postcode, served: true)
    click_button 'Check'
    expect(page).to have_content 'Great news, we serve your area!'
  end

  it 'correctly handles space and sybols' do
    valid_served_postcode = 'SH24 £""£!%     .-1AA'
    visit '/'
    fill_in 'postcode_checker_index_postcode', with: valid_served_postcode
    double_location_checker(postcode: valid_served_postcode, served: true)
    click_button 'Check'
    expect(page).to have_content 'Great news, we serve your area!'
  end
end
