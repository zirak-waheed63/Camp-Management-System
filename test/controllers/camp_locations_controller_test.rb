require 'test_helper'

class CampLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camp_location = camp_locations(:one)
  end

  test "should get index" do
    get camp_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_camp_location_url
    assert_response :success
  end

  test "should create camp_location" do
    assert_difference('CampLocation.count') do
      post camp_locations_url, params: { camp_location: { name: @camp_location.name } }
    end

    assert_redirected_to camp_location_url(CampLocation.last)
  end

  test "should show camp_location" do
    get camp_location_url(@camp_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_camp_location_url(@camp_location)
    assert_response :success
  end

  test "should update camp_location" do
    patch camp_location_url(@camp_location), params: { camp_location: { name: @camp_location.name } }
    assert_redirected_to camp_location_url(@camp_location)
  end

  test "should destroy camp_location" do
    assert_difference('CampLocation.count', -1) do
      delete camp_location_url(@camp_location)
    end

    assert_redirected_to camp_locations_url
  end
end
