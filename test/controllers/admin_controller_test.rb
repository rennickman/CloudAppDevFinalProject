require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get writings" do
    get admin_writings_url
    assert_response :success
  end

  test "should get questions" do
    get admin_questions_url
    assert_response :success
  end

  test "should get comments" do
    get admin_comments_url
    assert_response :success
  end

  test "should get users" do
    get admin_users_url
    assert_response :success
  end

  test "should get show_writing" do
    get admin_show_writing_url
    assert_response :success
  end

  test "should get show_question" do
    get admin_show_question_url
    assert_response :success
  end
end
