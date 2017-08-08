require "application_system_test_case"

class AdminAdminUsersTest < ApplicationSystemTestCase
  setup do
    visit admin_root_path
    fill_in "Email", with: "admin@test.com"
    fill_in "Password", with: "12345678"
    click_button "Login"
  end

  test "visiting the index" do
    visit admin_admin_users_path
    assert_selector("h2#page_title", text: "Admin Users")
  end

  test "new admin form" do
    visit new_admin_admin_user_path
    assert_selector("h2#page_title", text: "New Admin User")
  end

  test "visit" do
    admin = admin_users("admin_one")
    visit admin_admin_user_path(admin)
    assert_selector("h2#page_title", text: admin.email)
  end
end
