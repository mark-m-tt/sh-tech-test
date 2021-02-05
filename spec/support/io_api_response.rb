# frozen_string_literal: true

module IoApiResponse
  def api_response # rubocop:disable Metrics/MethodLength
    {
      'status' => 200,
      'result' => {
        'postcode' => 'SW1A 2AA',
        'quality' => 1,
        'eastings' => 530_047,
        'northings' => 179_951,
        'country' => 'England',
        'nhs_ha' => 'London',
        'longitude' => -0.127695,
        'latitude' => 51.50354,
        'european_electoral_region' => 'London',
        'primary_care_trust' => 'Westminster',
        'region' => 'London',
        'lsoa' => 'Westminster 018C',
        'msoa' => 'Westminster 018',
        'incode' => '2AA',
        'outcode' => 'SW1A',
        'parliamentary_constituency' => 'Cities of London and Westminster',
        'admin_district' => 'Westminster',
        'parish' => 'Westminster, unparished area',
        'admin_county' => nil,
        'admin_ward' => "St James's",
        'ced' => nil,
        'ccg' => 'NHS Central London (Westminster)',
        'nuts' => 'Westminster',
        'codes' => {
          'admin_district' => 'E09000033',
          'admin_county' => 'E99999999',
          'admin_ward' => 'E05000644',
          'parish' => 'E43000236',
          'parliamentary_constituency' => 'E14000639',
          'ccg' => 'E38000031',
          'ccg_id' => '09A',
          'ced' => 'E99999999',
          'nuts' => 'UKI32',
          'lsoa' => 'E01004736',
          'msoa' => 'E02000977',
          'lau2' => 'E05000644'
        }
      }
    }
  end

  def dummy_lambeth_response
    {
      'status' => 200,
      'result' => {
        'lsoa' => 'Lambeth'
      }
    }
  end

  def dummy_hounslow_response
    {
      'status' => 200,
      'result' => {
        'lsoa' => 'Hounslow'
      }
    }
  end
end
