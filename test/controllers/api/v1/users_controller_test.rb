require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new
    @user.username = rand_username
    @user.password = 'This is a v4lid password'
  end

  teardown do
    @user.destroy if @user.present?
  end

  test "should create user" do
    post api_v1_users_url, params: { username: @user.username, password: @user.password }, as: :json

    assert_response :created
    result = JSON.parse @response.body
    username = result['message'].split(' ')[0]
    assert_equal @user.username, username
  end

  # test "should update user" do
  #   patch api_v1_user_url(@user.username), params: { username: @user.username, password: 'This 1s also a v4lid password' }, as: :json
  #
  #   assert_response :created
  #   result = JSON.parse @response.body
  #   username = result['message'].split(' ')[0]
  #   assert_equal @user.username, username
  # end
end
