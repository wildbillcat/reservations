require "minitest_helper"

class CanAccessHomeTest < MiniTest::Rails::ActionDispatch::IntegrationTest
  test "the homepage has content" do
    visit root_path
    assert page.has_content?("Reservations") #a capybara assertion - see https://github.com/jnicklas/capybara/#the-dsl for more
  end
end
