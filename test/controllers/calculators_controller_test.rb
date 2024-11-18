require "test_helper"

class CalculatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get abv" do
    get calculators_abv_url
    assert_response :success
  end

  test "should get density_correction" do
    get calculators_density_correction_url
    assert_response :success
  end
end
