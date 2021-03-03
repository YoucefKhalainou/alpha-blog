require "test_helper"

class SigningUpUserTest < ActionDispatch::IntegrationTest
  test "Signing up a user" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'Example User', email: 'user@example.com', password: 'password'}}
      assert_redirected_to articles_path
      assert_equal 'Welcome to Alpha Blog Example User, you have successfully signed up', flash[:notice]
    end  
  end
end
