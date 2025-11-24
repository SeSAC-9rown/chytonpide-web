require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get log" do
    get pages_log_url
    assert_response :success
  end

  test "should get mypage" do
    get pages_mypage_url
    assert_response :success
  end
end
