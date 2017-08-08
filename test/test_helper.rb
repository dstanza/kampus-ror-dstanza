require 'simplecov'
SimpleCov.start 'rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def init_omniauth_data
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '123545',
      info: { email: "test-from-facebook@test.com", name: "test"},
      extra: {raw_info: ""}
      # etc.
    })
  end
  # Add more helper methods to be used by all tests here...
end
