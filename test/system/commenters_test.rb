require "application_system_test_case"

class CommentersTest < ApplicationSystemTestCase
  setup do
    @commenter = commenters(:one)
  end

  test "visiting the index" do
    visit commenters_url
    assert_selector "h1", text: "Commenters"
  end

  test "should create commenter" do
    visit commenters_url
    click_on "New commenter"

    fill_in "Comment", with: @commenter.comment
    fill_in "Name", with: @commenter.name
    click_on "Create Commenter"

    assert_text "Commenter was successfully created"
    click_on "Back"
  end

  test "should update Commenter" do
    visit commenter_url(@commenter)
    click_on "Edit this commenter", match: :first

    fill_in "Comment", with: @commenter.comment
    fill_in "Name", with: @commenter.name
    click_on "Update Commenter"

    assert_text "Commenter was successfully updated"
    click_on "Back"
  end

  test "should destroy Commenter" do
    visit commenter_url(@commenter)
    click_on "Destroy this commenter", match: :first

    assert_text "Commenter was successfully destroyed"
  end
end
