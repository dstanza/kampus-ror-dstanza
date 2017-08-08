require "application_system_test_case"

class AdminTasksTest < ApplicationSystemTestCase
  setup do
    visit admin_root_path
    fill_in "Email", with: "admin@test.com"
    fill_in "Password", with: "12345678"
    click_button "Login"
  end

  test "visiting the index" do
    visit admin_tasks_path
    assert_selector("h2#page_title", text: "Tasks")
  end

  test "new tasks form" do
    visit new_admin_task_path
    assert_selector("h2#page_title", text: "New Task")
  end

  test "visit" do
    task = tasks(:one)
    visit admin_task_path(task)
    assert_selector("h2#page_title", text: task.title)
  end
end
