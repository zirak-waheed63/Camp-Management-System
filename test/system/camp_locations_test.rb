require "application_system_test_case"

class CampLocationsTest < ApplicationSystemTestCase
  setup do
    @camp_location = camp_locations(:one)
  end

  test "visiting the index" do
    visit camp_locations_url
    assert_selector "h1", text: "Camp Locations"
  end

  test "creating a Camp location" do
    visit camp_locations_url
    click_on "New Camp Location"

    fill_in "Name", with: @camp_location.name
    click_on "Create Camp location"

    assert_text "Camp location was successfully created"
    click_on "Back"
  end

  test "updating a Camp location" do
    visit camp_locations_url
    click_on "Edit", match: :first

    fill_in "Name", with: @camp_location.name
    click_on "Update Camp location"

    assert_text "Camp location was successfully updated"
    click_on "Back"
  end

  test "destroying a Camp location" do
    visit camp_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Camp location was successfully destroyed"
  end
end
