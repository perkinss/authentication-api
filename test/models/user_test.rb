require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
    @user.username = 'test-username'
    @user.password = 'Th1s is a v4lid password!'
  end

  def teardown
    @user.destroy
  end

  test 'user with unique username and valid password is valid' do
    assert @user.valid?
  end

  test 'user without password is invalid' do
    @user.password = nil
    refute @user.valid?
  end

  test 'user without username but with valid password is invalid' do
    @user.username = nil
    refute @user.valid?
  end

  test 'new user with duplicate name is invalid' do
    user2 = User.new
    user2.username = 'test-username'
    refute user2.valid?
  end

  test 'user with a short password is invalid' do
    @user.password = 'Sho1!'
    refute @user.valid?
  end

  test 'user without special character is invalid' do
    @user.password = 'ThisHasn0SpecialCharacters'
    refute @user.valid?
  end

  test 'user without uppercase is invalid' do
    @user.password = 'th1s is not a v4lid password!'
    refute @user.valid?
  end

  test 'user without lowercase is invalid' do
    @user.password = 'TH1S IS NOT A V4LID PASSWORD!'
    refute @user.valid?
  end

  test 'user without numerals is invalid' do
    @user.password = 'This is not a valid password!'
    refute @user.valid?
  end

end
