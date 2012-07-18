require "minitest_helper"

class UserIsValidTest < MiniTest::Rails::ActionDispatch::IntegrationTest
  describe User do
    it "must be valid" do
      user = FactoryGirl.create(:user) #FactoryGirl only creates valid objects of course ;D
      user.must_be :valid? #Minitest standard testing style
    end
  end

end
